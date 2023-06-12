<?php
/**
 * ProdutoReport Listing
 * @author  <juliabisolo>
 */
class ProdutoReport extends TPage
{
    private $datagrid; // listing
    private $deleteButton;
    private $postAction;
    private $formDatagrid;
    // private $panel;

    use Adianti\base\AdiantiStandardListTrait;
    
    /**
     * Class constructor
     * Creates the page, the form and the listing
     */
    public function __construct()
    {
        parent::__construct();

        $this->setDatabase('pronto_estoque');
        $this->setActiveRecord('Produto');
        $this->setDefaultOrder('id', 'asc');
        
        // creates the form
        $this->form = new BootstrapFormBuilder('form_search_Produto');
        $this->form->setFormTitle('FILTROS');
        $this->form->style = 'width: 10%';

        // create the form fields
        $id                   = new TEntry('id');
        $nome                 = new TEntry('nome');
        $descricao            = new TEntry('descricao');
        $categoria_produto_id = new TDBCombo('categoria_produto_id', 'pronto_estoque', 'CategoriaProduto', 'id', 'descricao', 'descricao');
        $fornecedor_id = new TDBCombo('fornecedor_id', 'pronto_estoque', 'Fornecedor', 'id', '{nome} ({cnpj})', 'nome');

        $id->setMask('9!');
        $id->setSize('100');
        $nome->setSize('300');
        $descricao->setSize('300');
        $categoria_produto_id->setSize('400');
        $categoria_produto_id->enableSearch();
        $fornecedor_id->setSize('400');
        $fornecedor_id->enableSearch();

        // add the fields
        $row = $this->form->addFields( [new TLabel('Id:'), $id] );
        $row = $this->form->addFields( [new TLabel('Nome:'), $nome] );
        $row = $this->form->addFields( [new TLabel('Descrição:'), $descricao]);
        $row = $this->form->addFields( [new TLabel('Categoria produto:'), $categoria_produto_id] );
        $row = $this->form->addFields( [new TLabel('Fornecedor:'), $fornecedor_id] );

        // keep the form filled during navigation with session data
        $this->form->setData( TSession::getValue('Produto_filter_data') );
        
        // add the search form actions
        $this->form->addAction(_t('Find'), new TAction(array($this, 'onSearch')), 'fa:search');

        // create the datagrid form wrapper
        $this->formDatagrid = new TForm('datagrid_form');

        // creates a Datagrid
        $this->datagrid = new BootstrapDatagridWrapper(new TDataGrid);
        $this->datagrid->disableDefaultClick();
        $this->datagrid->style = 'width: 100%';
        $this->formDatagrid->add($this->datagrid);

        $checktodos = new TElement('input');
        $checktodos->type = 'checkbox';
        $checktodos->title = 'Selecionar todos';
        $checktodos->onclick = "$('input:checkbox').not(this).prop('checked',this.checked);";

        // creates the datagrid columns
        $column_check                = new TDataGridColumn('check',                $checktodos,  'center', '5%' );
        $column_id                   = new TDataGridColumn('id',                   'Id',         'center', '5%' );
        $column_nome                 = new TDataGridColumn('nome',                 'Nome',       'left',   '30%');
        $column_categoria_produto_id = new TDataGridColumn('categoria_produto_id', 'Categoria',  'left',   '20%');
        $column_fornecedor_id        = new TDataGridColumn('fornecedor_id',        'Fornecedor', 'left',   '25%');
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
        $this->datagrid->addColumn($column_check);
        $this->datagrid->addColumn($column_id);       
        $this->datagrid->addColumn($column_nome);       
        $this->datagrid->addColumn($column_categoria_produto_id);       
        $this->datagrid->addColumn($column_fornecedor_id);       
        $this->datagrid->addColumn($column_quantidade);       
        $this->datagrid->addColumn($column_estoque_minimo);       
        $this->datagrid->addColumn($column_estoque_maximo);       
        
        // create the datagrid model
        $this->datagrid->createModel();

        // $this->panel = new TPanelGroup('Etiquetas em lote', 'white');
        // $this->panel->add($this->datagrid);
        
        $this->postAction = new TAction(array($this, 'gerarEtiquetaLote'));
        $post = new TButton('post');
        $post->setAction($this->postAction);
        $post->setImage('far:file-pdf red');
        $post->setLabel('Gerar etiquetas');

        $this->postAction = new TAction(array($this, 'onShowCurtainFilters'));
        $btn = new TButton('filter');
        $btn->setAction($this->postAction);
        $btn->setImage('fa:filter');
        $btn->setLabel('Filtros');
        
        $this->formDatagrid->addField($post);
        $this->formDatagrid->addField($btn);

        // vertical box container
        $container = new TVBox;
        $container->style = 'width: 100%';
        $container->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $container->add($post);
        $container->add($btn);
        $container->add($panel = TPanelGroup::pack('', $this->formDatagrid));
        $panel->getBody()->style = 'overflow-x: auto';

        parent::add($container);
    }

    public static function onShowCurtainFilters($param = null)
    {
        try
        {
            // create empty page for right panel
            $page = new TPage;
            $page->setTargetContainer('adianti_right_panel');
            $page->setProperty('override', 'true');
            $page->setPageName(__CLASS__);
            
            $btn_close = new TButton('closeCurtain');
            $btn_close->onClick = "Template.closeRightPanel();";
            $btn_close->setLabel("Fechar");
            $btn_close->setImage('fas:times');
            
            // instantiate self class, populate filters in construct 
            $embed = new self;
            $embed->form->addHeaderWidget($btn_close);
            
            // embed form inside curtain
            $page->add($embed->form);
            $page->setIsWrapped(true);
            $page->show();
        }
        catch (Exception $e) 
        {
            new TMessage('error', $e->getMessage());    
        }
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
                    $object->check = new TCheckButton('check_'.$object->id);
                    $object->check->setIndexValue('on');
                    $this->form->addField($object->check);
                    $this->datagrid->addItem($object);
                }
            }
            
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

    public function gerarEtiquetaLote($param)
    {
        $data = $this->form->getData();
        $this->form->setData($data);
        $selected_products = array();

        foreach ($this->form->getFields() as $name => $field)
        {
            if ($field instanceof TCheckButton)
            {
                $parts = explode('_', $name);
                $id = $parts[1];

                if ($field->getValue() == 'on')
                {
                    $selected_products[] = $id;
                }
            }
        }

        TTransaction::open('pronto_estoque');

        $produtos = array();

        foreach ($selected_products as $selected_product)
        {
            $produto = Produto::find($selected_product);
            $produtos[] = $produto;
        }

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