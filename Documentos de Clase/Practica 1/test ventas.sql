
DECLARE @XML XML;
SET @XML = '<rows><row>
    <productoid>1</productoid>
    <cantidad>3</cantidad>
    <precio>45.25</precio>
    <descuento>0</descuento>
    <importe>135.75</importe>
</row>
<row>
   <productoid>2</productoid>
    <cantidad>5</cantidad>
    <precio>52.04</precio>
    <descuento>0</descuento>
    <importe>260.2</importe>
</row></rows>';

exec sp_tbl_ventas_venta_enc_guardar 0, '2016-09-21', '-', '-', 1, @XML;

