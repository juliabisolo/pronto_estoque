<?php
/**
 * Cidade Active Record
 * @author  <juliabisolo>
 */
class Cidade extends TRecord
{
    const TABLENAME = 'public.cidade';
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