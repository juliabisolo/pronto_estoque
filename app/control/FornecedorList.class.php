<?php
/**
 * FornecedorList Listing
 * @author  <juliabisolo>
 */
class FornecedorList extends TPage
{
    private $form; // form
    private $datagrid; // listing
    private $pageNavigation;
    private $formgrid;
    private $loaded;
    private $deleteButton;
    
    /**
     * Class constructor
     * Creates the page, the form and the listing
     */
    public function __construct()
    {
        parent::__construct();
        
        // creates the items form and add a table inside
        $this->form = new BootstrapFormBuilder('form_search_fornecedor');
        $this->form->setFieldSizes('100%');
        $this->form->setFormTitle('FORNECEDORES');

        // create the form fields
        $id    = new TEntry('id');
        $nome  = new TEntry('nome');
        $cnpj  = new TEntry('cnpj');
        $ativo = new TRadioGroup('ativo');

        $ativo->setUseButton();
        $ativo->setBooleanMode();
        $id->setMask('9!');
        $cnpj->setMask('99.999.999/9999-99');

        // add the fields
        $row = $this->form->addFields( [new TLabel('Id:'), $id],
                                       [new TLabel('Nome:'), $nome] );
        $row->layout = ['col-sm-2', 'col-sm-10'];

        $row = $this->form->addFields( [new TLabel('CNPJ:'), $cnpj],
                                       [new TLabel('Ativo:'), $ativo] );
        $row->layout = ['col-sm-3', 'col-sm-6'];

        // keep the form filled during navigation with session data
        $this->form->setData( TSession::getValue('Fornecedor_filter_data') );
        
        // add the search form actions
        $this->form->addAction(_t('Find'), new TAction(array($this, 'onSearch')), 'fa:search');
        $this->form->addAction(_t('New'),  new TAction(array('FornecedorForm', 'onEdit')), 'fa:plus-circle green');
        
        // creates a Datagrid
        $this->datagrid = new TDataGrid;
        $this->datagrid->disableDefaultClick();
        $this->datagrid->style = 'width: 100%';
        $this->datagrid->setHeight(400);

        // creates the datagrid columns
        $column_id       = new TDataGridColumn('id',       'Id',       'center', '5%' );
        $column_nome     = new TDataGridColumn('nome',     'Nome',     'left',   '25%');
        $column_cnpj     = new TDataGridColumn('cnpj',     'CNPJ',     'center', '15%');
        $column_email    = new TDataGridColumn('email',    'E-mail',   'left',   '20%');
        $column_telefone = new TDataGridColumn('telefone', 'Telefone', 'center', '14%');
        $column_celular  = new TDataGridColumn('celular',  'Celular',  'center', '14%');
        $column_ativo    = new TDataGridColumn('ativo',    'Ativo',    'center', '3%' );

        $column_ativo->setTransformer(function($ativo)
        {
            $icone = new TElement('i');
            
            $title = 'Inativo';
            $class = "times";
            $icone->style = "padding-right:4px; color:red";

            if($ativo)
            {
                $title = 'Ativo';    
                $class = "check";
                $icone->style = "padding-right:4px; color:green";
            }

            $icone->title = $title;
            $icone->class = "fa fa-{$class} fa-fw";

            return $icone;
        });

        // add the columns to the DataGrid
        $this->datagrid->addColumn($column_id);       
        $this->datagrid->addColumn($column_nome);       
        $this->datagrid->addColumn($column_cnpj);       
        $this->datagrid->addColumn($column_email);       
        $this->datagrid->addColumn($column_telefone);       
        $this->datagrid->addColumn($column_celular);       
        $this->datagrid->addColumn($column_ativo);       
		
		// create EDIT action
        $action_edit = new TDataGridAction(array('FornecedorForm', 'onEdit'));
        $action_edit->setUseButton(TRUE);
        $action_edit->setButtonClass('btn btn-default');
        $action_edit->setLabel(_t('Edit'));
        $action_edit->setImage('fa:edit blue');
        $action_edit->setField('id');
		
        //create DELETE action
        $action_delete = new TDataGridAction(array($this, 'onDelete'));
        $action_delete->setUseButton(TRUE);
        $action_delete->setButtonClass('btn btn-default');
        $action_delete->setLabel(('Excluir'));
        $action_delete->setImage('fa:trash-alt red');
        $action_delete->setField('id');

        //create DESATIVAR action
        $action_desativar = new TDataGridAction(array($this, 'onDesativar'));
        $action_desativar->setUseButton(TRUE);
        $action_desativar->setButtonClass('btn btn-default');
        $action_desativar->setLabel(('Desativar'));
        $action_desativar->setImage('fa:user-times red');
        $action_desativar->setField('id');
        $action_desativar->setDisplayCondition( array($this, 'displayDesativa') );

        //create ATIVAR action
        $action_ativar = new TDataGridAction(array($this, 'onAtivar'));
        $action_ativar->setUseButton(TRUE);
        $action_ativar->setButtonClass('btn btn-default');
        $action_ativar->setLabel(('Ativar'));
        $action_ativar->setImage('fa:user green');
        $action_ativar->setField('id');
        $action_ativar->setDisplayCondition( array($this, 'displayAtiva') );

        $action_group = new TDataGridActionGroup('Ações', 'bs:th');        
        $action_group->addAction($action_edit);
        $action_group->addAction($action_delete);
        $action_group->addAction($action_desativar);
        $action_group->addAction($action_ativar);
        
        $this->datagrid->addActionGroup($action_group);
        
        // create the datagrid model
        $this->datagrid->createModel();
        
        // creates the page navigation
        $this->pageNavigation = new TPageNavigation;
        $this->pageNavigation->setAction(new TAction(array($this, 'onReload')));
        $this->pageNavigation->setWidth($this->datagrid->getWidth());
        
        // vertical box container
        $container = new TVBox;
        $container->style = 'width: 100%';
        $container->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $container->add($this->form);
        $container->add($this->datagrid);
        $container->add($this->pageNavigation);
        
        parent::add($container);
    }

    public function onDesativar($param)
    {
        $action = new TAction(array(__CLASS__, 'desativa'));
        $action->setParameters($param); // pass the key parameter ahead
        
        // shows a dialog to the user
        new TQuestion('Você tem certeza que deseja desativar este fornecedor?', $action);
    }

    public function desativa($param)
    {
        TTransaction::open('pronto_estoque');
        $fornecedor = new Fornecedor($param['id']);
        $fornecedor->ativo = FALSE;
        $fornecedor->store();
        AdiantiCoreApplication::gotoPage('FornecedorList');
        TTransaction::close();
    }

    public static function onAtivar($param)
    {
        $action = new TAction(array(__CLASS__, 'ativa'));
        $action->setParameters($param); // pass the key parameter ahead
        
        // shows a dialog to the user
        new TQuestion('Você tem certeza que deseja ativar este fornecedor?', $action);
    }

    public function ativa($param)
    {
        TTransaction::open('pronto_estoque');
        $fornecedor = new Fornecedor($param['id']);
        $fornecedor->ativo = TRUE;
        $fornecedor->store();
        AdiantiCoreApplication::gotoPage('FornecedorList');
        TTransaction::close();
    }

    public function displayAtiva($fornecedor)
    {
        if($fornecedor->ativo)
        {
            return false;
        }
        return true;
    }

    public function displayDesativa($fornecedor)
    {
        if(!$fornecedor->ativo)
        {
            return false;
        }
        return true;
    }

    /**
     * Register the filter in the session
     */
    public function onSearch()
    {
        // get the search form data
        $data = $this->form->getData();
        
        // clear session filters
        TSession::setValue('FornecedorList_filter_id',    NULL);
        TSession::setValue('FornecedorList_filter_nome',  NULL);
        TSession::setValue('FornecedorList_filter_cnpj',  NULL);
        TSession::setValue('FornecedorList_filter_ativo', NULL);

        if (isset($data->id) AND ($data->id))
        {
            $filter = new TFilter('id', '=', "{$data->id}"); // create the filter
            TSession::setValue('FornecedorList_filter_id', $filter); // stores the filter in the session
        }

        if (isset($data->nome) AND ($data->nome))
        {
            $filter = new TFilter('nome', 'ilike', "%{$data->nome}%"); // create the filter
            TSession::setValue('FornecedorList_filter_nome', $filter); // stores the filter in the session
        }

        if (isset($data->cnpj) AND ($data->cnpj))
        {
            $filter = new TFilter('cnpj', '=', "{$data->cnpj}"); // create the filter
            TSession::setValue('FornecedorList_filter_cnpj', $filter); // stores the filter in the session
        }

        if (isset($data->ativo))
        {
            $filter = new TFilter('ativo', 'is', $data->ativo); // create the filter
            TSession::setValue('FornecedorList_filter_ativo', $filter); // stores the filter in the session
        }
        
        // fill the form with data again
        $this->form->setData($data);
        
        // keep the search data in the session
        TSession::setValue('Fornecedor_filter_data', $data);
        
        $param=array();
        $param['offset']    =0;
        $param['first_page']=1;
        $this->onReload($param);
    }
    
    /**
     * Load the datagrid with data
     */
    public function onReload($param = NULL)
    {
        try
        {
            // open a transaction with database 'agenda_julia'
            TTransaction::open('pronto_estoque');
            
            // creates a repository for Pessoa
            $repository = new TRepository('Fornecedor');
            
            $limit = 10;

            // creates a criteria
            $criteria = new TCriteria;
            
            // default order
            if (empty($param['order']))
            {
                $param['direction'] = 'asc';
            }
            $criteria->setProperties($param); // order, offset
            $criteria->setProperty('limit', $limit);

            if (TSession::getValue('FornecedorList_filter_id')) {
                $criteria->add(TSession::getValue('FornecedorList_filter_id')); // add the session filter
            }

            if (TSession::getValue('FornecedorList_filter_nome')) {
                $criteria->add(TSession::getValue('FornecedorList_filter_nome')); // add the session filter
            }

            if (TSession::getValue('FornecedorList_filter_cnpj')) {
                $criteria->add(TSession::getValue('FornecedorList_filter_cnpj')); // add the session filter
            }

            if (TSession::getValue('FornecedorList_filter_ativo')) {
                $criteria->add(TSession::getValue('FornecedorList_filter_ativo')); // add the session filter
            }

            // load the objects according to criteria
            $objects = $repository->load($criteria, FALSE);

            if (is_callable($this->transformCallback))
            {
                call_user_func($this->transformCallback, $objects, $param);
            }
            
            $this->datagrid->clear();
            if ($objects)
            {
                // iterate the collection of active records
                foreach ($objects as $object)
                {
                    // add the object inside the datagrid
                    $this->datagrid->addItem($object);
                }
            }
            
            // reset the criteria for record count
            $criteria->resetProperties();
            $count= $repository->count($criteria);
            $this->pageNavigation->setCount($count); // count of records
            $this->pageNavigation->setProperties($param); // order, page
            $this->pageNavigation->setLimit($limit); // limit
            
            // close the transaction
            TTransaction::close();
            $this->loaded = true;
        }
        catch (Exception $e) // in case of exception
        {
            // shows the exception error message
            new TMessage('error', $e->getMessage());
            // undo all pending operations
            TTransaction::rollback();
        }
    }

    /**
     * Ask before deletion
     */
    public function onDelete($param)
    {
        // define the delete action
        $action = new TAction(array($this, 'Delete'));
        $action->setParameters($param); // pass the key parameter ahead
        
        // shows a dialog to the user
        new TQuestion('Você tem certeza que deseja excluir este fornecedor?', $action);
    }
    
    /**
     * Delete a record
     */
    public function Delete($param)
    {
        try
        {
            // get the parameter $key
            $key=$param['key'];
            // open a transaction with database
            TTransaction::open('pronto_estoque');
            
            // instantiates object
            $object = new Fornecedor($key, FALSE);
            
            // deletes the object from the database
            $object->delete();
            
            // close the transaction
            TTransaction::close();
            
            // reload the listing
            $this->onReload( $param );
            // shows the success message
            new TMessage('info', AdiantiCoreTranslator::translate('Record deleted'));
        }
        catch (Exception $e) // in case of exception
        {
            // shows the exception error message
            new TMessage('error', 'Não foi possível excluir o fornecedor, pois há produtos vinculados a ele.');
            // undo all pending operations
            TTransaction::rollback();
        }
    }
    
    /**
     * method show()
     * Shows the page
     */
    public function show()
    {
        // check if the datagrid is already loaded
        if (!$this->loaded AND (!isset($_GET['method']) OR !(in_array($_GET['method'],  array('onReload', 'onSearch')))) )
        {
            if (func_num_args() > 0)
            {
                $this->onReload( func_get_arg(0) );
            }
            else
            {
                $this->onReload();
            }
        }
        parent::show();
    }
}