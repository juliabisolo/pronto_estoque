<?php
/**
 * EtiquetasPDF
 * @author  <juliabisolo>
 */
class EtiquetasPDF extends TPage
{
    public static function gerarCodigodeBarras($produtos)
    {
        try
        {            
            $properties['barcodeMethod'] = 'EAN13';
            $properties['leftMargin']    = 12;
            $properties['topMargin']     = 12;
            $properties['labelWidth']    = 64;
            $properties['labelHeight']   = 54;
            $properties['spaceBetween']  = 4;
            $properties['rowsPerPage']   = 5;
            $properties['colsPerPage']   = 3;
            $properties['fontSize']      = 12;
            $properties['barcodeHeight'] = 15;
            $properties['imageMargin']   = 0;
            
            TTransaction::open('pronto_estoque');

            $generator = new AdiantiBarcodeDocumentGenerator;
            $generator->setProperties($properties);

            $template = TipoEtiqueta::find(1)->template_barcode;

            if(!$template)
            {
                $label  = '' . "\n";
                $label .= '<b>Id</b>: {$id}' . "\n";
                $label .= '<b>Nome</b>: {$nome}' . "\n";
                $label .= '#barcode#' . "\n";
                $label .= '   {$barcode}';
                $template = $label;
            }

            $generator->setLabelTemplate($template);

            foreach ($produtos as $produto)
            {
                $produto->barcode = str_pad($produto->id, 10, '0', STR_PAD_LEFT);
                $produto->nome    = substr($produto->nome, 0, 15);
                $generator->addObject($produto);
            }
            
            $generator->setBarcodeContent('barcode');
            $generator->generate();
            $generator->save('app/output/barcodes.pdf');
            
            $window = TWindow::create('Código de barras', 0.8, 0.8);
            $object = new TElement('object');
            $object->data  = 'app/output/barcodes.pdf';
            $object->type  = 'application/pdf';
            $object->style = "width: 100%; height:calc(100% - 10px)";
            $object->add('O navegador não suporta a exibição deste conteúdo, <a style="color:#007bff;" target=_newwindow href="'.$object->data.'"> clique aqui para baixar</a>...');
            
            $window->add($object);
            $window->show();
            
            TTransaction::close();
        }
        catch (Exception $e)
        {
            new TMessage('error', $e->getMessage());
        }
    }

    public static function gerarQrCode($produtos)
    {
        try
        {            
            $properties['leftMargin']    = 12;
            $properties['topMargin']     = 12;
            $properties['labelWidth']    = 64;
            $properties['labelHeight']   = 54;
            $properties['spaceBetween']  = 0;
            $properties['rowsPerPage']   = 5;
            $properties['colsPerPage']   = 3;
            $properties['fontSize']      = 10;
            $properties['barcodeHeight'] = 20;
            $properties['imageMargin']   = 0;
            
            TTransaction::open('pronto_estoque');

            $generator = new AdiantiBarcodeDocumentGenerator;
            $generator->setProperties($properties);

            $template = TipoEtiqueta::find(1)->template_qrcode;

            if(!$template)
            {
                $label  = '' . "\n";
                $label .= '<b>Id</b>: {$id}' . "\n";
                $label .= '<b>Nome</b>: {$nome}' . "\n";
                $label .= '#qrcode#';
                $template = $label;
            }

            $generator->setLabelTemplate($template);

            foreach ($produtos as $produto)
            {
                $produto->id_pad = str_pad($produto->id, 10, '0', STR_PAD_LEFT);
                $generator->addObject($produto);
            }
            
            $generator->setBarcodeContent('{id}');
            $generator->generate();
            $generator->save('app/output/qrcodes.pdf');
            
            $window = TWindow::create('QR Code', 0.8, 0.8);
            $object = new TElement('object');
            $object->data  = 'app/output/qrcodes.pdf';
            $object->type  = 'application/pdf';
            $object->style = "width: 100%; height:calc(100% - 10px)";
            $object->add('O navegador não suporta a exibição deste conteúdo, <a style="color:#007bff;" target=_newwindow href="'.$object->data.'"> clique aqui para baixar</a>...');
            
            $window->add($object);
            $window->show();
            
            TTransaction::close();
        }
        catch (Exception $e)
        {
            new TMessage('error', $e->getMessage());
        }
    }
}
