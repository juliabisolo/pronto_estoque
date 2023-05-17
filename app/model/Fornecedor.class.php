<?php
/**
 * Fornecedor Active Record
 * @author  <juliabisolo>
 */
class Fornecedor extends TRecord
{
    const TABLENAME = 'public.fornecedor';
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
        parent::addAttribute('email');
        parent::addAttribute('telefone');
        parent::addAttribute('celular');
        parent::addAttribute('rua');
        parent::addAttribute('numero');
        parent::addAttribute('complemento');
        parent::addAttribute('bairro');
        parent::addAttribute('cep');
        parent::addAttribute('ativo');
        parent::addAttribute('cnpj');
        parent::addAttribute('cidade_id');
        parent::addAttribute('estado_id');
    }
}