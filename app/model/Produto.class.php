<?php
/**
 * Produto Active Record
 * @author  <juliabisolo>
 */
class Produto extends TRecord
{
    const TABLENAME = 'public.produto';
    const PRIMARYKEY= 'id';
    const IDPOLICY =  'max'; // {max, serial}
    
    /**
     * Constructor method
     */
    public function __construct($id = NULL, $callObjectLoad = TRUE)
    {
        parent::__construct($id, $callObjectLoad);
        parent::addAttribute('nome');
        parent::addAttribute('descricao');
        parent::addAttribute('validade');
        parent::addAttribute('preco');
        parent::addAttribute('estoque_minimo');
        parent::addAttribute('estoque_maximo');
        parent::addAttribute('quantidade');
        parent::addAttribute('dt_cadastro');
        parent::addAttribute('dt_atualizacao');
        parent::addAttribute('categoria_produto_id');
        parent::addAttribute('fornecedor_id');
    }
}