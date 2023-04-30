<?php
/**
 * ProdutoForm
 * @author  <juliabisolo>
 */
class ProdutoForm extends TPage
{
    protected $form; // form

    use Adianti\Base\AdiantiStandardFormTrait; // Standard form methods
    
    /**
     * Form constructor
     * @param $param Request
     */
    public function __construct($param)
    {
        parent::__construct();

        $this->setDatabase('tem_estoque');
        $this->setActiveRecord('Produto');
        
        // creates the form
        $this->form = new BootstrapFormBuilder('form_Produto_form');
        $this->form->setFormTitle('CADASTRO DE PRODUTO');
        $this->form->setFieldSizes('100%');
        $this->form->setProperty('style', 'margin-bottom:0');

        // create the form fields
        $id = new THidden('id');
        $nome = new TEntry('nome');
        $descricao = new TText('descricao');
        $validade = new TDate('validade');
        $preco = new TEntry('preco');
        $quantidade = new TEntry('quantidade');
        $estoque_minimo = new TEntry('estoque_minimo');
        $estoque_maximo = new TEntry('estoque_maximo');
        $dt_cadastro = new TDateTime('dt_cadastro');
        $dt_atualizacao = new TDateTime('dt_atualizacao');
        $categoria_produto_id = new TDBCombo('categoria_produto_id', 'tem_estoque', 'CategoriaProduto', 'id', 'descricao', 'descricao');
        $filter = new TCriteria;
        $filter->add(new TFilter('ativo', 'is', true));
        $fornecedor_id = new TDBCombo('fornecedor_id', 'tem_estoque', 'Fornecedor', 'id', '{nome} ({cnpj})', 'nome');

        $categoria_produto_id->enableSearch();
        $fornecedor_id->enableSearch();

        // define the sizes
        $id->setSize(40);
        $nome->setSize(100);
        $descricao->setSize(100);
        $validade->setSize(50);
        $preco->setSize(20);
        $quantidade->setSize(50);
        $estoque_minimo->setSize(20);
        $estoque_maximo->setSize(200);
        $categoria_produto_id->setSize(8);
        $fornecedor_id->setSize(80);
        $dt_cadastro->setSize(50);
        $dt_atualizacao->setSize(50);

        $validade->setMask('dd/mm/yyyy');
        $validade->setDatabaseMask('dd/mm/yyyy');
        $preco->setNumericMask(2, ',', '.', true);
        $quantidade->setMask('9!');
        $estoque_minimo->setMask('9!');
        $estoque_maximo->setMask('9!');
        
        $dt_cadastro->setValue(date('d/m/Y H:i:s'));
        $dt_cadastro->setMask('dd/mm/yyyy hh:ii:ss');
        $dt_cadastro->setDatabaseMask('dd/mm/yyyy hh:ii:ss');
        $dt_cadastro->setEditable(false);

        $dt_atualizacao->setValue(date('d/m/Y H:i:s'));
        $dt_atualizacao->setMask('dd/mm/yyyy hh:ii:ss');
        $dt_atualizacao->setDatabaseMask('dd/mm/yyyy hh:ii:ss');
        $dt_atualizacao->setEditable(false);

        $nome->addValidation('Nome', new TRequiredValidator); // obrigatório
        $descricao->addValidation('Descrição', new TRequiredValidator); // obrigatório
        $quantidade->addValidation('Quantidade', new TRequiredValidator); // obrigatório
        $estoque_minimo->addValidation('Estoque mínimo', new TRequiredValidator); // obrigatório
        $categoria_produto_id->addValidation('Categoria produto', new TRequiredValidator); // obrigatório

        // add one row for each form field
        $this->form->addFields([$id]);

        $this->form->addFields ([new TLabel('Nome*:', 'red'), $nome]);
        $this->form->addFields ([new TLabel('Descrição*:', 'red'), $descricao]);
        
        $row = $this->form->addFields( [new TLabel('Validade:'), $validade],
                                       [new TLabel('Preço:'), $preco] );
        $row->layout = ['col-sm-3', 'col-sm-3', 'col-sm-3', 'col-sm-3'];

        $row = $this->form->addFields( [new TLabel('Quantidade*:', 'red'), $quantidade],
                                       [new TLabel('Estoque mínimo*:', 'red'), $estoque_minimo],
                                       [new TLabel('Estoque máximo:'), $estoque_maximo] );
        $row->layout = ['col-sm-3', 'col-sm-3', 'col-sm-3', 'col-sm-3'];

        $this->form->addFields ([new TLabel('Categoria produto*:', 'red'), $categoria_produto_id]);
        $this->form->addFields ([new TLabel('Fornecedor*:', 'red'), $fornecedor_id]);

        $row = $this->form->addFields( [new TLabel('Data cadastro*', 'red'), $dt_cadastro],
                                       [new TLabel('Data atualização*:', 'red'), $dt_atualizacao] );
        $row->layout = ['col-sm-3', 'col-sm-3', 'col-sm-3', 'col-sm-3'];

        $this->form->addAction( _t('Save'),   new TAction(array($this, 'onSave')),   'fa:save green');
        $this->form->addAction(_t('Cancel'), new TAction(array('ProdutoList', 'onReload')), 'far:times-circle red');
        
        // vertical box container
        $container = new TVBox;
        $container->style = 'width: 100%';
        $container->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $container->add($this->form);
        
        parent::add($container);
    }

    /**
     * Save form data
     * @param $param Request
     */
    public function onSave($param)
    {
        try
        {
            // open a transaction with database 'samples'
            TTransaction::open('tem_estoque');
            
            $this->form->validate(); // form validation
            
            // get the form data into an active record Entry
            $data = $this->form->getData();
            $object = new Produto();
            $object->id = $data->id;
            $object->nome = $data->nome;
            $object->descricao = $data->descricao;
            $object->validade = $data->validade;
            $object->preco = $data->preco;
            $object->quantidade = $data->quantidade;
            $object->estoque_minimo = $data->estoque_minimo;
            $object->estoque_maximo = $data->estoque_maximo;
            $object->dt_cadastro = $data->dt_cadastro;
            $object->dt_atualizacao = date('d/m/Y H:i:s');
            $object->categoria_produto_id = $data->categoria_produto_id;
            $object->fornecedor_id = $data->fornecedor_id;

            $object->store(); // stores the object

            $data->id = $object->id;
            $this->form->setData($data); // keep form data

            $this->fireEvents( $object );
            
            TTransaction::close(); // close the transaction
            $posAction = new TAction(array('ProdutoList', 'onReload'));
            
            // shows the success message
            new TMessage('info', TAdiantiCoreTranslator::translate('Record saved'), $posAction);
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

    /**
     * Load object to form data
     * @param $param Request
     */
    public function onEdit( $param )
    {
         try
        {
            if (empty($this->database))
            {
                throw new Exception(AdiantiCoreTranslator::translate('^1 was not defined. You must call ^2 in ^3', AdiantiCoreTranslator::translate('Database'), 'setDatabase()', AdiantiCoreTranslator::translate('Constructor')));
            }
            
            if (empty($this->activeRecord))
            {
                throw new Exception(AdiantiCoreTranslator::translate('^1 was not defined. You must call ^2 in ^3', 'Active Record', 'setActiveRecord()', AdiantiCoreTranslator::translate('Constructor')));
            }
            
            if (isset($param['key']))
            {
                // get the parameter $key
                $key=$param['key'];
                
                // open a transaction with database
                TTransaction::open($this->database);
                
                $class = $this->activeRecord;
                
                // instantiates object
                $object = new $class($key);

                $validade = $this->formatDate($object->validade);
                $object->validade = $validade;

                $dt_cadastro = $this->formatDateTime($object->dt_cadastro);
                $object->dt_cadastro = $dt_cadastro;

                $dt_atualizacao = $this->formatDateTime($object->dt_atualizacao);
                $object->dt_atualizacao = $dt_atualizacao;

                // fill the form with the active record data
                $this->form->setData($object);
                // close the transaction
                TTransaction::close();

                $this->fireEvents( $object );
                
                return $object;
            }
            else
            {
                $this->form->clear();
                $data = new stdClass;
                $data->dt_cadastro = (date('d/m/Y H:i:s'));
                $data->dt_atualizacao = (date('d/m/Y H:i:s'));
                $this->form->setData($data);
            }
        }
        catch (Exception $e) // in case of exception
        {
            // shows the exception error message
            new TMessage('error', $e->getMessage());
            // undo all pending operations
            TTransaction::rollback();
        }
    }

    public function formatDateTime($date)
    {
        $timestamp = strtotime($date);
        $dateFormatted = date("d/m/Y H:i:s", $timestamp);

        return $dateFormatted;
    }

    public function formatDate($date)
    {
        $timestamp = strtotime($date);
        $dateFormatted = date("d/m/Y", $timestamp);

        return $dateFormatted;
    }

    public function fireEvents( $object )
    {
        $obj = new stdClass;
        $obj->categoria_produto_id = $object->categoria_produto_id;
        $obj->fornecedor_id        = $object->fornecedor_id;
        TForm::sendData('form_Produto_form', $obj);
    }
}