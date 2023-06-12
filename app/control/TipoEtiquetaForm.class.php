<?php
/**
 * TipoEtiquetaForm
 * @author  <juliabisolo>
 */
class TipoEtiquetaForm extends TPage
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

        $this->setDatabase('pronto_estoque');
        $this->setActiveRecord('TipoEtiqueta');
        
        // creates the form
        $this->form = new BootstrapFormBuilder('form_tipo_etiqueta');
        $this->form->setFormTitle('CONFIGURAÇÃO DE ETIQUETAS');
        $this->form->setFieldSizes('100%');
        $this->form->setProperty('style', 'margin-bottom:0');

        // create the form fields
        $id    = new THidden('id');
        $tipo_etiqueta = new TRadioGroup('value');
        $template_qrcode = new TText('template_qrcode');
        $template_barcode = new TText('template_barcode');

        $options = ['q' => 'QR Code<br><img src="app/images/qrcode_example.png">',
        			'b' => 'Código de barras<br><img src="app/images/barcode_example.png">'];
        $tipo_etiqueta->addItems($options);
        $tipo_etiqueta->addValidation('Tipo de etiqueta', new TRequiredValidator); // obrigatório
        $tipo_etiqueta->setLayout('horizontal');

        // add one row for each form field
        $this->form->addFields([$id]);
        
        $row = $this->form->addFields([new TLabel('Selecione o tipo de etiqueta desejada*:', 'red'), $tipo_etiqueta]);
        $row = $this->form->addFields([new TLabel('Template QR Code:'), $template_qrcode]);
        $row = $this->form->addFields([new TLabel('Template código de barras:'), $template_barcode]);

        $this->form->addAction( _t('Save'),   new TAction(array($this, 'onSave')),   'fa:save green');
        
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
            TTransaction::open('pronto_estoque');
            
            $this->form->validate(); // form validation
            
            // get the form data into an active record Entry
            $data = $this->form->getData();
            $object = new TipoEtiqueta();
            $object->id = $data->id;
            $object->value = $data->value;
            $object->template_qrcode = $data->template_qrcode;
            $object->template_barcode = $data->template_barcode;
            
            $object->store(); // stores the object
            
            $data->id = $object->id;
            $this->form->setData($data); // keep form data
            
            TTransaction::close(); // close the transaction
            
            // shows the success message
            new TMessage('info', 'Configuração de etiqueta salva');
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
            
            // get the parameter $key
            $key = 1;
            
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
        catch (Exception $e) // in case of exception
        {
            // shows the exception error message
            new TMessage('error', $e->getMessage());
            // undo all pending operations
            TTransaction::rollback();
        }
    }
}