<?php
/**
 * FornecedorForm
 * @author  <juliabisolo>
 */
class FornecedorForm extends TPage
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
        $this->setActiveRecord('Fornecedor');
        
        // creates the form
        $this->form = new BootstrapFormBuilder('form_Fornecedor_form');
        $this->form->setFormTitle('CADASTRO DE FORNECEDOR');
        $this->form->setFieldSizes('100%');
        $this->form->setProperty('style', 'margin-bottom:0');

        // create the form fields
        $id = new THidden('id');
        $nome = new TEntry('nome');
        $descricao = new TText('descricao');
        $email = new TEntry('email');
        $telefone = new TEntry('telefone');
        $celular = new TEntry('celular');
        $rua = new TEntry('rua');
        $numero = new TEntry('numero');
        $complemento = new TEntry('complemento');
        $bairro = new TEntry('bairro');
        $cep = new TEntry('cep');
        $ativo = new TRadioGroup('ativo');
        $cnpj = new TEntry('cnpj');
        $filter = new TCriteria;
        $filter->add(new TFilter('estado_id', '<', '0'));
        $estado_id = new TDBCombo('estado_id', 'tem_estoque', 'Estado', 'id', 'nome', 'nome');
        $cidade_id = new TDBCombo('cidade_id', 'tem_estoque', 'Cidade', 'id', 'nome', 'nome');

        $estado_id->enableSearch();
        $cidade_id->enableSearch();
        $ativo->setUseButton();
        $ativo->setBooleanMode();
        $ativo->setValue(true);

        // define the sizes
        $id->setSize(40);
        $nome->setSize(100);
        $email->setSize(50);
        $telefone->setSize(20);
        $celular->setSize(20);
        $rua->setSize(200);
        $numero->setSize(50);
        $complemento->setSize(50);
        $bairro->setSize(50);
        $cep->setSize(8);
        $ativo->setSize(80);
        $cnpj->setSize(14);

        $telefone->setMask('(99) 9999-9999');
        $celular->setMask('(99) 99999-9999');
        $cep->setMask('99999-999');
        $cnpj->setMask('99.999.999/9999-99');

        $nome->addValidation('Nome', new TRequiredValidator); // obrigatório
        $email->addValidation('E-mail', new TRequiredValidator); // obrigatório
        $telefone->addValidation('Telefone', new TRequiredValidator); // obrigatório
        $celular->addValidation('Celular', new TRequiredValidator); // obrigatório
        $rua->addValidation('Rua', new TRequiredValidator); // obrigatório
        $numero->addValidation('Número', new TRequiredValidator); // obrigatório
        $bairro->addValidation('Bairro', new TRequiredValidator); // obrigatório
        $cep->addValidation('CEP', new TRequiredValidator); // obrigatório
        $cidade_id->addValidation('Cidade', new TRequiredValidator); // obrigatório
        $estado_id->addValidation('Estado', new TRequiredValidator); // obrigatório
        $cnpj->addValidation('CNPJ', new TRequiredValidator); // obrigatório
        $cnpj->addValidation('CNPJ', new TCNPJValidator); // valida cnpj

        // add one row for each form field
        $this->form->addFields([$id]);
        
        $row = $this->form->addFields( [new TLabel('Nome*:', 'red'), $nome],
                                       [new TLabel('CNPJ*:', 'red'), $cnpj] );
        $row->layout = ['col-sm-8', 'col-sm-4'];

        $this->form->addFields( [new TLabel('Descrição:'), $descricao] );
        $this->form->addFields( [new TLabel('Ativo:')], [$ativo]);
        
        $label1 = new TLabel('Contato', '#5A73DB', 12, '');
        $label1->style='text-align:left;border-bottom:1px solid #c0c0c0;width:100%';
        $this->form->addContent( [$label1] );

        $row = $this->form->addFields( [new TLabel('E-mail*:', 'red'), $email],
                                       [new TLabel('Telefone*:', 'red'), $telefone],
                                       [new TLabel('Celular*:', 'red'), $celular] );
        $row->layout = ['col-sm-6', 'col-sm-3', 'col-sm-3'];

        $label2 = new TLabel('Endereço', '#5A73DB', 12, '');
        $label2->style='text-align:left;border-bottom:1px solid #c0c0c0;width:100%';
        $this->form->addContent( [$label2] );
        
        $row = $this->form->addFields( [new TLabel('Rua*:', 'red'), $rua],
                                       [new TLabel('Número*:', 'red'), $numero],
                                       [new TLabel('Complemento:'), $complemento] );
        $row->layout = ['col-sm-7', 'col-sm-2', 'col-sm-3'];

        $row = $this->form->addFields( [new TLabel('Bairro*:', 'red'), $bairro],
                                       [new TLabel('Estado*:', 'red'), $estado_id],
                                       [new TLabel('Cidade*:', 'red'), $cidade_id] );
        $row->layout = ['col-sm-4', 'col-sm-4', 'col-sm-4'];
        $row = $this->form->addFields( [new TLabel('CEP*:', 'red'), $cep] );
        $row->layout = ['col-sm-4', 'col-sm-4', 'col-sm-4'];

        $estado_id->setChangeAction( new TAction( array($this, 'onChangeEstado' )) );

        $this->form->addAction( _t('Save'),   new TAction(array($this, 'onSave')),   'fa:save green');
        $this->form->addAction(_t('Cancel'), new TAction(array('FornecedorList', 'onReload')), 'far:times-circle red');
        
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
            $object = new Fornecedor();
            $object->id = $data->id;
            $object->nome = $data->nome;
            $object->descricao = $data->descricao;
            $object->email = $data->email;
            $object->telefone = $data->telefone;
            $object->celular = $data->celular;
            $object->rua = $data->rua;
            $object->numero = $data->numero;
            $object->complemento = $data->complemento;
            $object->bairro = $data->bairro;
            $object->cep = $data->cep;
            $object->cidade_id = $data->cidade_id;
            $object->estado_id = $data->estado_id;
            $object->cnpj = $data->cnpj;
            $object->ativo = $data->ativo;
            
            $object->store(); // stores the object
            
            $data->id = $object->id;
            $this->form->setData($data); // keep form data

            $this->fireEvents( $object );
            
            TTransaction::close(); // close the transaction
            $posAction = new TAction(array('FornecedorList', 'onReload'));
            
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

                $this->fireEvents( $object );
                
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

    public function fireEvents( $object )
    {
        $obj = new stdClass;
        $obj->estado_id    = $object->estado_id;
        $obj->cidade_id    = $object->cidade_id;
        TForm::sendData('form_Fornecedor_form', $obj);
    }

    public static function onChangeEstado($param)
    {
        try
        {
            TTransaction::open('tem_estoque');
            if (!empty($param['estado_id']))
            {
                $criteria = TCriteria::create( ['estado_id' => $param['estado_id'] ] );
                
                TDBCombo::reloadFromModel('form_Fornecedor_form', 'cidade_id', 'tem_estoque', 'Cidade', 'id', '{nome}', 'nome', $criteria, TRUE);
            }
            else
            {
                TCombo::clearField('form_Fornecedor_form', 'cidade_id');
            }
            
            TTransaction::close();
        }
        catch (Exception $e)
        {
            new TMessage('error', $e->getMessage());
        }
    }
}