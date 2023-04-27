<?php
/**
 * Estado Active Record
 * @author  <juliabisolo>
 */
class Estado extends TRecord
{
    const TABLENAME = 'public.estado';
    const PRIMARYKEY= 'id';
    const IDPOLICY =  'max'; // {max, serial}
    
    /**
     * Constructor method
     */
    public function __construct($id = NULL, $callObjectLoad = TRUE)
    {
        parent::__construct($id, $callObjectLoad);
        parent::addAttribute('nome');
    }
}