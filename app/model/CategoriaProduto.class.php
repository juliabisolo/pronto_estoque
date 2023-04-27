<?php
/**
 * CategoriaProduto Active Record
 * @author  <juliabisolo>
 */
class CategoriaProduto extends TRecord
{
    const TABLENAME = 'public.categoria_produto';
    const PRIMARYKEY= 'id';
    const IDPOLICY =  'max'; // {max, serial}
    
    /**
     * Constructor method
     */
    public function __construct($id = NULL, $callObjectLoad = TRUE)
    {
        parent::__construct($id, $callObjectLoad);
        parent::addAttribute('descricao');
        parent::addAttribute('ativo');
    }
}