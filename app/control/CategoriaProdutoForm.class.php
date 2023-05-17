<?php
/**
 * CategoriaProdutoForm
 * @author  <juliabisolo>
 */
class CategoriaProdutoForm extends TPage
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
        $this->setActiveRecord('CategoriaProduto');
        
        // creates the form
        $this->form = new BootstrapFormBuilder('form_CategoriaProduto_form');
        $this->form->setFormTitle('CADASTRO DE CATEGORIA DE PRODUTOS');
        $this->form->setFieldSizes('100%');
        $this->form->setProperty('style', 'margin-bottom:0');

        // create the form fields
        $id = new THidden('id');
        $descricao = new TEntry('descricao');
        $ativo = new TRadioGroup('ativo');

        $ativo->setUseButton();
        $ativo->setBooleanMode();
        $ativo->setValue(true);
        $descricao->addValidation('Descrição', new TRequiredValidator); // obrigatório

        // define the sizes
        $id->setSize(40);
        $descricao->setSize(250);
        $ativo->setSize(80);

        // add one row for each form field
        $this->form->addFields([$id]);
        $this->form->addFields( [new TLabel('Descrição*:', 'red'), $descricao] );
        $this->form->addFields([new TLabel('Ativo:')], [$ativo]);
        
        $this->form->addAction( _t('Save'),   new TAction(array($this, 'onSave')),   'fa:save green');
        $this->form->addAction(_t('Cancel'), new TAction(array('CategoriaProdutoList', 'onReload')), 'far:times-circle red');
        
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
            
            $object = new CategoriaProduto();
            $object->id = $data->id;
            $object->descricao = $data->descricao;
            $object->ativo = $data->ativo;
            
            $object->store(); // stores the object
            
            $data->id = $object->id;
            $this->form->setData($data); // keep form data
            
            TTransaction::close(); // close the transaction
            $posAction = new TAction(array('CategoriaProdutoList', 'onReload'));
            
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

                // fill the form with the active record data
                $this->form->setData($object);
                // close the transaction
                TTransaction::close();
                
                return $object;
            }
            else
            {
                $this->form->clear();
                $data = new stdClass;
                $data->ativo = true;
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
}