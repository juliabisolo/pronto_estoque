<?php
/**
 * FormCodeReader
 *
 */
class FormCodeReader extends TPage
{
    private $id;
    private $produto_id;
    protected $form;

    use Adianti\Base\AdiantiStandardFormTrait; // Standard form methods

    public function __construct()
    {
        parent::__construct();

        TTransaction::open('tem_estoque');

        $tipo_etiqueta = TipoEtiqueta::find(1);

        TTransaction::close();

        // create the form
        $this->form = new BootstrapFormBuilder('reader');
        
        // create the form fields
        $barcode = new TBarCodeInputReader('barcode');
        $qrcode  = new TQRCodeInputReader('qrcode');
        $nome = new TEntry('nome');
        $quantidade = new TEntry('quantidade');
        $estoque_minimo = new TEntry('estoque_minimo');
        $estoque_maximo = new TEntry('estoque_maximo');
        $quantidade_mov = new TEntry('quantidade_mov');

        $barcode->setEditable(false);
        $qrcode->setEditable(false);
        $nome->setEditable(false);
        $quantidade->setEditable(false);
        $estoque_minimo->setEditable(false);
        $estoque_maximo->setEditable(false);
        
        $barcode->setSize('100%');
        $qrcode->setSize('100%');
        $nome->setSize('100%');

        $quantidade_mov->setMask('9!');
        $quantidade_mov->addValidation('Quantidade movimentação', new TRequiredValidator); // obrigatório
        
        $barcode->setChangeAction( new TAction( [$this, 'onChangeBarcode'] ) );
        $qrcode->setChangeAction( new TAction( [$this, 'onChangeQRCode'] ) );
        
        $this->form->addContent( [new TFormSeparator('Dados do produto')] );

        if($tipo_etiqueta->value === 'q')
        {
            $row = $this->form->addFields( [new TLabel('QRCode'), $qrcode]);
            $row->layout = ['col-sm-2'];
        }
        else
        {
            $row = $this->form->addFields( [new TLabel('Código de barras:'), $barcode]);
            $row->layout = ['col-sm-2'];
        }
        
        $row = $this->form->addFields( [new TLabel('Nome:'), $nome]);
        $row->layout = ['col-sm-2'];

        $row = $this->form->addFields( [new TLabel('Estoque mínimo:'), $estoque_minimo],
                                       [new TLabel('Estoque máximo:'), $estoque_maximo]);
        $row->layout = ['col-sm-2', 'col-sm-2'];

        $row = $this->form->addFields( [new TLabel('Quantidade atual:'), $quantidade]);
        $row->layout = ['col-sm-2'];

        $this->form->addContent( [new TFormSeparator('<br>Movimentação de estoque')] );

        $row = $this->form->addFields( [new TLabel('Quantidade movimentação*:', 'red'), $quantidade_mov]);
        $row->layout = ['col-sm-2'];

        $btn = $this->form->addAction('Adicionar', new TAction(array($this, 'adicionarEstoque')), 'fa:plus green');
        $btn->class = 'btn btn-sm btn-primary btn-lg';
        $btn2 = $this->form->addAction('Remover', new TAction(array($this, 'removerEstoque')), 'fa:minus');
        $btn2->class = 'btn btn-sm btn-danger btn-lg';

        $panel = new TPanelGroup();

        $this->html = new THtmlRenderer('app/resources/page_sample.html');

        //busca último log de movimentação de estoque feita pelo usuário
        TTransaction::open('log');
        $criteria = new TCriteria;
        $criteria->add(new TFilter('login', '=', TSession::getValue('login')));
        $criteria->add(new TFilter('class_name', '=', 'FormCodeReader'));
        $criteria->add(new TFilter('columnname', '=', 'quantidade'));
        $criteria->setProperty('order', 'id desc');
        $log = SystemChangeLog::getObjects($criteria);
        $log = $log[0];
        TTransaction::close();

        //busca nome do produto
        TTransaction::open('tem_estoque');
        $produto = Produto::find($log->pkvalue);
        TTransaction::close();

        //formatação de data
        $timestamp = strtotime($log->logdate);
        $dateFormatted = date("d/m/Y H:i:s", $timestamp);
        
        //replaces mensagem última movimentação
        $replaces = [];
        $replaces['login']  = $log->login;
        $replaces['nome']  = $produto->nome;
        $replaces['valor_antigo'] = $log->oldvalue;
        $replaces['valor_novo']   = $log->newvalue;
        $replaces['data']   = $dateFormatted;
        
        // replace the main section variables
        $this->html->enableSection('main', $replaces);
        
        $panel->add($this->html);
        
        // wrap the page content using vertical box
        $vbox = new TVBox;
        $vbox->style = 'width: 100%';
        $vbox->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $vbox->add($this->form);
        parent::add($vbox);
        $vbox->add($panel);
    }

    public static function onChangeBarcode($param)
    {
        try
        {
            TTransaction::open('tem_estoque');

            $barcode = ltrim($param['barcode'], '0');
            $barcode = substr($barcode, 0, -1);
            $barcode = intval($barcode);
            $produto = Produto::find($barcode);

            if ($produto)
            {
                $obj = new stdClass;
                $obj->nome  = $produto->nome;
                $obj->quantidade  = $produto->quantidade;
                $obj->estoque_minimo  = $produto->estoque_minimo;
                $obj->estoque_maximo  = $produto->estoque_maximo;

                TForm::sendData('reader', $obj);
            }
            
            TTransaction::close();
        }
        catch (Exception $e)
        {
            new TMessage('warning', 'Produto não registrado.');
            $obj = new stdClass;
            $obj->barcode = '';
            TForm::sendData('reader',$obj);
        }
    }

    public static function onChangeQRCode($param)
    {
        try
        {
            TTransaction::open('tem_estoque');

            $produto = Produto::find($param['qrcode']);

            if ($produto)
            {
                $obj = new stdClass;
                $obj->nome  = $produto->nome;
                $obj->quantidade  = $produto->quantidade;
                $obj->estoque_minimo  = $produto->estoque_minimo;
                $obj->estoque_maximo  = $produto->estoque_maximo;

                TForm::sendData('reader', $obj);
            }
            
            TTransaction::close();
        }
        catch (Exception $e)
        {
            new TMessage('warning', 'Produto não registrado.');
            $obj = new stdClass;
            $obj->barcode = '';
            TForm::sendData('reader',$obj);
        }
    }

    public function adicionarEstoque($param)
    {
        try
        {
            $this->form->validate(); // form validation

            // open a transaction with database 'samples'
            TTransaction::open('tem_estoque');

            $tipo_etiqueta = TipoEtiqueta::find(1);

            if($tipo_etiqueta->value === 'q')
            {
                $idProduto = $param['qrcode'];
            }
            else
            {
                $idProduto = $this->decodificarBarcode($param['barcode']);
            }
            
            $produtoBefore = Produto::find($idProduto);

            // get the form data into an active record Entry
            $data = $this->form->getData();
            $object = new Produto();
            $object->id = $idProduto;
            $object->nome = $produtoBefore->nome;
            $object->descricao = $produtoBefore->descricao;
            $object->validade = $produtoBefore->validade;
            $object->preco = $produtoBefore->preco;
            $object->quantidade = $data->quantidade_mov + $produtoBefore->quantidade;
            $object->estoque_minimo = $produtoBefore->estoque_minimo;
            $object->estoque_maximo = $produtoBefore->estoque_maximo;
            $object->dt_cadastro = $produtoBefore->dt_cadastro;
            $object->dt_atualizacao = date('d/m/Y H:i:s');
            $object->categoria_produto_id = $produtoBefore->categoria_produto_id;
            $object->fornecedor_id = $produtoBefore->fornecedor_id;

            $object->store(); // stores the object
            
            TTransaction::close(); // close the transaction
            
            // shows the success message
            $posAction = new TAction([__CLASS__, 'onReload']);

            new TMessage('info', 'Estoque atualizado!<br>' . $data->quantidade_mov . ' unidade(s) adicionada(s).', $posAction);
        }
        catch (Exception $e) // in case of exception
        {
            // shows the exception error message
            new TMessage('error', 'Não foi possível movimentar o estoque!<br>Por favor, tente novamente.');
            
            $this->form->setData( $this->form->getData() ); // keep form data
            
            // undo all pending operations
            TTransaction::rollback();
        }
    }

    public function removerEstoque($param)
    {
        try
        {
            $this->form->validate(); // form validation

            // open a transaction with database 'samples'
            TTransaction::open('tem_estoque');
            
            $tipo_etiqueta = TipoEtiqueta::find(1);

            if($tipo_etiqueta->value === 'q')
            {
                $idProduto = $param['qrcode'];
            }
            else
            {
                $idProduto = $this->decodificarBarcode($param['barcode']);
            }

            $produtoBefore = Produto::find($idProduto);

            // get the form data into an active record Entry
            $data = $this->form->getData();
            $object = new Produto();
            $object->id = $idProduto;
            $object->nome = $produtoBefore->nome;
            $object->descricao = $produtoBefore->descricao;
            $object->validade = $produtoBefore->validade;
            $object->preco = $produtoBefore->preco;
            $object->quantidade = $produtoBefore->quantidade - $data->quantidade_mov;
            $object->estoque_minimo = $produtoBefore->estoque_minimo;
            $object->estoque_maximo = $produtoBefore->estoque_maximo;
            $object->dt_cadastro = $produtoBefore->dt_cadastro;
            $object->dt_atualizacao = date('d/m/Y H:i:s');
            $object->categoria_produto_id = $produtoBefore->categoria_produto_id;
            $object->fornecedor_id = $produtoBefore->fornecedor_id;

            $object->store(); // stores the object
            
            TTransaction::close(); // close the transaction
            
            // shows the success message
            $posAction = new TAction([__CLASS__, 'onReload']);
            new TMessage('info', 'Estoque atualizado!<br>' . $data->quantidade_mov . ' unidade(s) removida(s).', $posAction);
        }
        catch (Exception $e) // in case of exception
        {
            // shows the exception error message
            new TMessage('error', 'Não foi possível movimentar o estoque!<br>Por favor, tente novamente.');

            $this->form->setData( $this->form->getData() ); // keep form data
            
            // undo all pending operations
            TTransaction::rollback();
        }
    }

    function decodificarBarcode($barcode)
    {
        $idProduto = ltrim($barcode, '0');
        $idProduto = substr($idProduto, 0, -1);
        $idProduto = intval($idProduto);

        return $idProduto;
    }

    function onReload($param = NULL)
    {
        try
        {
            AdiantiCoreApplication::gotoPage('FormCodeReader');
        }
        catch (Exception $e) // in case of exception
        {
            // shows the exception error message
            new TMessage('error', $e->getMessage());
            
            // undo all pending operations
            TTransaction::rollback();
        }
    }
}

?>
