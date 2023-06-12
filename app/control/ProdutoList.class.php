<?php
/**
 * ProdutoList Listing
 * @author  <juliabisolo>
 */
class ProdutoList extends TPage
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
        $this->form = new BootstrapFormBuilder('form_search_produto');
        $this->form->setFieldSizes('100%');
        $this->form->setFormTitle('PRODUTOS');

        // create the form fields
        $id                   = new TEntry('id');
        $nome                 = new TEntry('nome');
        $descricao            = new TEntry('descricao');
        $categoria_produto_id = new TDBCombo('categoria_produto_id', 'pronto_estoque', 'CategoriaProduto', 'id', 'descricao', 'descricao');
        $fornecedor_id = new TDBCombo('fornecedor_id', 'pronto_estoque', 'Fornecedor', 'id', '{nome} ({cnpj})', 'nome');

        $id->setMask('9!');
        $categoria_produto_id->enableSearch();
        $fornecedor_id->enableSearch();

        // add the fields
        $row = $this->form->addFields( [new TLabel('Id:'), $id],
                                       [new TLabel('Nome:'), $nome] );
        $row->layout = ['col-sm-2', 'col-sm-10'];

        $row = $this->form->addFields( [new TLabel('Descrição:'), $descricao]);
        $row->layout = ['col-sm-12'];

        $row = $this->form->addFields( [new TLabel('Categoria produto:'), $categoria_produto_id],
                                       [new TLabel('Fornecedor:'), $fornecedor_id] );
        $row->layout = ['col-sm-6', 'col-sm-6'];

        // keep the form filled during navigation with session data
        $this->form->setData( TSession::getValue('Produto_filter_data') );
        
        // add the search form actions
        $this->form->addAction(_t('Find'), new TAction(array($this, 'onSearch')), 'fa:search');
        $this->form->addAction(_t('New'),  new TAction(array('ProdutoForm', 'onEdit')), 'fa:plus-circle green');

        // creates a Datagrid
        $this->datagrid = new BootstrapDatagridWrapper(new TDataGrid);
        $this->datagrid->disableDefaultClick();
        $this->datagrid->style = 'width: 100%';
        $this->datagrid->setHeight(400);

        // creates the datagrid columns
        $column_id                   = new TDataGridColumn('id',                   'Id',         'center', '5%' );
        $column_nome                 = new TDataGridColumn('nome',                 'Nome',       'left',   '30%');
        $column_categoria_produto_id = new TDataGridColumn('categoria_produto_id', 'Categoria',  'left',   '20%');
        $column_fornecedor_id        = new TDataGridColumn('fornecedor_id',        'Fornecedor', 'left',   '30%');
        $column_quantidade           = new TDataGridColumn('quantidade',           'Quantidade', 'center', '5%' );
        $column_estoque_minimo       = new TDataGridColumn('estoque_minimo',       'Mínimo',     'center', '5%' );
        $column_estoque_maximo       = new TDataGridColumn('estoque_maximo',       'Máximo',     'center', '5%' );

        $column_id->setAction(new TAction([$this, 'onReload']), ['order' => 'id']);
        $column_nome->setAction(new TAction([$this, 'onReload']), ['order' => 'nome']);
        $column_categoria_produto_id->setAction(new TAction([$this, 'onReload']), ['order' => 'categoria_produto_id']);
        $column_fornecedor_id->setAction(new TAction([$this, 'onReload']), ['order' => 'fornecedor_id']);
        $column_quantidade->setAction(new TAction([$this, 'onReload']), ['order' => 'quantidade']);
        $column_estoque_minimo->setAction(new TAction([$this, 'onReload']), ['order' => 'estoque_minimo']);
        $column_estoque_maximo->setAction(new TAction([$this, 'onReload']), ['order' => 'estoque_maximo']);

        $column_categoria_produto_id->setTransformer([$this, 'transformerCategoria']);
        $column_fornecedor_id->setTransformer([$this, 'transformerFornecedor']);

        // add the columns to the DataGrid
        $this->datagrid->addColumn($column_id);       
        $this->datagrid->addColumn($column_nome);       
        $this->datagrid->addColumn($column_categoria_produto_id);       
        $this->datagrid->addColumn($column_fornecedor_id);       
        $this->datagrid->addColumn($column_quantidade);       
        $this->datagrid->addColumn($column_estoque_minimo);       
        $this->datagrid->addColumn($column_estoque_maximo);       
		
		// create EDIT action
        $action_edit = new TDataGridAction(array('ProdutoForm', 'onEdit'));
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

        //create GERAR ETIQUETA action
        $action_etiqueta = new TDataGridAction(array($this, 'gerarEtiqueta'));
        $action_etiqueta->setUseButton(TRUE);
        $action_etiqueta->setButtonClass('btn btn-default');
        $action_etiqueta->setLabel('Gerar etiqueta');
        $action_etiqueta->setImage('far:file-pdf green');
        $action_etiqueta->setField('id');

        $action_group = new TDataGridActionGroup('Ações', 'bs:th');        
        $action_group->addAction($action_edit);
        $action_group->addAction($action_delete);
        $action_group->addAction($action_etiqueta);

        $this->datagrid->addActionGroup($action_group);

        $actionDescricao = new TDataGridAction(array($this, 'onShowDetail'), ['id' => '{id}'] );
        $this->datagrid->addAction($actionDescricao, 'Descrição', 'fa:search #2c2c2c');
        
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

    public function onShowDetail( $param )
    {
        // get row position
        $pos = $this->datagrid->getRowIndex('id', $param['key']);
        
        // get row by position
        $current_row = $this->datagrid->getRow($pos);
        $current_row->style = "background-color: #af4507; color:white; text-shadow:none";
        
        TTransaction::open('pronto_estoque');
        $objProduto = new Produto($param['key']);
        TTransaction::close('pronto_estoque');

        $objProduto->descricao = nl2br($objProduto->descricao);

        // create a new row
        $row = new TTableRow;
        $row->style = "background-color: #f39e6c";
        $row->addCell('');
        $cell = $row->addCell($objProduto->descricao);
        $cell->colspan = 12;
        $cell->style='padding:10px;';
        
        // insert the new row
        $this->datagrid->insert($pos +1, $row);
    }

    public function transformerCategoria($categoria_produto_id, $produto, $row)
    {
        if($produto->categoria_produto_id)
        {
            $objCategoria = new CategoriaProduto($produto->categoria_produto_id);
            return $objCategoria->descricao;
        }

        return '';
    }

    public function transformerFornecedor($fornecedor_id, $produto, $row)
    {
        if($produto->fornecedor_id)
        {
            $objFornecedor = new Fornecedor($produto->fornecedor_id);
            return $objFornecedor->nome;
        }

        return '';
    }

    /**
     * Register the filter in the session
     */
    public function onSearch()
    {
        // get the search form data
        $data = $this->form->getData();
        
        // clear session filters
        TSession::setValue('ProdutoList_filter_id',                   NULL);
        TSession::setValue('ProdutoList_filter_nome',                 NULL);
        TSession::setValue('ProdutoList_filter_descricao',            NULL);
        TSession::setValue('ProdutoList_filter_categoria_produto_id', NULL);
        TSession::setValue('ProdutoList_filter_fornecedor_id',        NULL);

        if (isset($data->id) AND ($data->id))
        {
            $filter = new TFilter('id', '=', "{$data->id}"); // create the filter
            TSession::setValue('ProdutoList_filter_id', $filter); // stores the filter in the session
        }

        if (isset($data->nome) AND ($data->nome))
        {
            $filter = new TFilter('nome', 'ilike', "%{$data->nome}%"); // create the filter
            TSession::setValue('ProdutoList_filter_nome', $filter); // stores the filter in the session
        }

        if (isset($data->descricao) AND ($data->descricao))
        {
            $filter = new TFilter('descricao', 'ilike', "%{$data->descricao}%"); // create the filter
            TSession::setValue('ProdutoList_filter_descricao', $filter); // stores the filter in the session
        }

        if (isset($data->categoria_produto_id) AND ($data->categoria_produto_id))
        {
            $filter = new TFilter('categoria_produto_id', '=', "{$data->categoria_produto_id}"); // create the filter
            TSession::setValue('ProdutoList_filter_categoria_produto_id', $filter); // stores the filter in the session
        }

        if (isset($data->fornecedor_id) AND ($data->fornecedor_id))
        {
            $filter = new TFilter('fornecedor_id', '=', "{$data->fornecedor_id}"); // create the filter
            TSession::setValue('ProdutoList_filter_fornecedor_id', $filter); // stores the filter in the session
        }

        // fill the form with data again
        $this->form->setData($data);
        
        // keep the search data in the session
        TSession::setValue('Produto_filter_data', $data);
        
        $param = array();
        $param['offset']     = 0;
        $param['first_page'] = 1;
        $this->onReload($param);
    }
    
    /**
     * Load the datagrid with data
     */
    public function onReload($param = NULL)
    {
        try
        {
            // open a transaction with database 'pronto_estoque'
            TTransaction::open('pronto_estoque');
            
            // creates a repository for Pessoa
            $repository = new TRepository('Produto');
            
            $limit = 10;

            // creates a criteria
            $criteria = new TCriteria;
            
            // default order
            if (empty($param['order']))
            {
                $param['order'] = 'nome';
                $param['direction'] = 'asc';
            }

            $criteria->setProperties($param); // order, offset
            $criteria->setProperty('limit', $limit);

            if (TSession::getValue('ProdutoList_filter_id')) {
                $criteria->add(TSession::getValue('ProdutoList_filter_id')); // add the session filter
            }

            if (TSession::getValue('ProdutoList_filter_nome')) {
                $criteria->add(TSession::getValue('ProdutoList_filter_nome')); // add the session filter
            }

            if (TSession::getValue('ProdutoList_filter_descricao')) {
                $criteria->add(TSession::getValue('ProdutoList_filter_descricao')); // add the session filter
            }

            if (TSession::getValue('ProdutoList_filter_categoria_produto_id')) {
                $criteria->add(TSession::getValue('ProdutoList_filter_categoria_produto_id')); // add the session filter
            }

            if (TSession::getValue('ProdutoList_filter_fornecedor_id')) {
                $criteria->add(TSession::getValue('ProdutoList_filter_fornecedor_id')); // add the session filter
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

    public static function gerarEtiqueta($param)
    {
        TTransaction::open('pronto_estoque');

        $produto = Produto::find($param['key']);
        $produtos[] = $produto;

        $tipo_etiqueta = TipoEtiqueta::find(1);

        if($tipo_etiqueta->value === 'q')
        {
            EtiquetasPDF::gerarQrCode($produtos);
        }
        else
        {
            EtiquetasPDF::gerarCodigodeBarras($produtos);
        }

        TTransaction::close();
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
        new TQuestion('Você tem certeza que deseja excluir este produto e todo seu registro de estoque?', $action);
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
            $object = new Produto($key, FALSE);
            
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
            new TMessage('error', 'Erro ao excluir o produto.');
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
        if (!$this->loaded AND (!isset($_GET['method']) OR 
            !(in_array($_GET['method'],  array('onReload', 'onSearch')))) )
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