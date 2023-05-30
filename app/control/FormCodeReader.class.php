<?php
/**
 * FormCodeReader
 *
 */
class FormCodeReader extends TPage
{
    private $id;
    protected $form;
    private $produto_id;

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
        
        $barcode->setSize(300);
        $qrcode->setSize(300);
        $nome->setSize(600);

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
        $row->layout = ['col-sm-3'];

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
        
        // wrap the page content using vertical box
        $vbox = new TVBox;
        $vbox->style = 'width: 100%';
        $vbox->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $vbox->add($this->form);
        parent::add($vbox);
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
            else
            {
                // new TMessage('warning', 'Produto não registrado.');
                // $obj = new stdClass;
                // $obj->barcode = '';
                // TForm::sendData('reader',$obj);
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

            $qrcode = explode("-", $param['qrcode']);
            $produto = Produto::find($qrcode[0]);

            if ($produto)
            {
                $obj = new stdClass;
                $obj->nome  = $produto->nome;
                $obj->quantidade  = $produto->quantidade;
                $obj->estoque_minimo  = $produto->estoque_minimo;
                $obj->estoque_maximo  = $produto->estoque_maximo;

                TForm::sendData('reader', $obj);
            }
            else
            {
                new TMessage('warning', 'Produto não registrado.');
                $obj = new stdClass;
                $obj->barcode = '';
                TForm::sendData('reader',$obj);
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
            // open a transaction with database 'samples'
            TTransaction::open('tem_estoque');
            
            $this->form->validate(); // form validation

            $barcode = ltrim($param['barcode'], '0');
            $barcode = substr($barcode, 0, -1);
            $barcode = intval($barcode);

            $produtoBefore = Produto::find($barcode);

            // get the form data into an active record Entry
            $data = $this->form->getData();
            $object = new Produto();
            $object->id = $barcode;
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
            new TMessage('info', 'Estoque atualizado!<br>' . $data->quantidade_mov . ' unidade(s) adicionada(s).');

            $obj = new stdClass;
            $obj->barcode = '';
            $obj->nome = '';
            $obj->estoque_minimo = '';
            $obj->estoque_maximo = '';
            $obj->quantidade = '';
            $obj->quantidade_mov = '';

            TForm::sendData('reader',$obj);
        }
        catch (Exception $e) // in case of exception
        {
            // shows the exception error message
            new TMessage('error', $e->getMessage());
            
            $this->form->setData( $this->form->getData() ); // keep form data
            
            // undo all pending operations
            TTransaction::rollback();
        }
    }

    public static function removerEstoque($param)
    {
        
    }
}

?>
