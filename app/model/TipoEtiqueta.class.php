<?php
/**
 * TipoEtiqueta Active Record
 * @author  <juliabisolo>
 */
class TipoEtiqueta extends TRecord
{
    const TABLENAME = 'public.tipo_etiqueta';
    const PRIMARYKEY= 'id';
    const IDPOLICY =  'max'; // {max, serial}
    
    /**
     * Constructor method
     */
    public function __construct($id = NULL, $callObjectLoad = TRUE)
    {
        parent::__construct($id, $callObjectLoad);
        parent::addAttribute('value');
        parent::addAttribute('template_qrcode');
        parent::addAttribute('template_barcode');
    }
}