@AbapCatalog.sqlViewName: 'ZSD_V_INVOICE_IT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item CDS Session 2'
define view ZSD_DDL_INVOICE_ITEM


  as select from    vbrp as vbp
    inner join      vbrk as vbk on vbk.vbeln = vbp.vbeln
    inner join      mara as mra on mra.matnr = vbp.matnr
    left outer join vbak as vba on vba.vbeln = vbp.aubel
    left outer join kna1 as kna on kna.kunnr = vba.kunnr
    left outer join makt as mkt on mkt.matnr = mra.matnr

{
  key vbp.vbeln,
  key vbp.posnr,
      vbp.aubel,
      vbp.aupos,
      vba.kunnr,
      concat_with_space( kna.name1, kna.name2, 1 )         as kunnrAd,

      currency_conversion( amount => vbp.netwr,
                          source_currency => vbk.waerk,
                          target_currency => cast( 'EUR'as abap.cuky) ,
                          exchange_rate_date => vbk.fkdat) as conversion_netwr,
      left( vba.kunnr, 3 )                                 as left_kunnr,
      length(vbp.matnr)                                    as matnr_length,

      case
      when vbk.fkart  = 'FAS'  then 'Peşinat talebi iptali'
      when  vbk.fkart = 'FAZ'  then 'Peşinat Talebi'
      else 'Fatura' end                                    as fkart_type,
      vbk.fkdat,
      vbk.inco2_l




}
