@AbapCatalog.sqlViewName: 'ZMM_V_PURCORDER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order'
define view ZMM_DDL_PURCORDER

  as select from ekko as ekk
    inner join   ekpo as ekp on ekp.ebeln = ekk.ebeln
    inner join   mara as mra on mra.matnr = ekp.matnr
    inner join   makt as mkt on  mkt.matnr = mra.matnr
                             and mkt.spras = $session.system_language
    inner join   lfa1 as lfa on lfa.lifnr = ekk.lifnr
{

  key ekp.ebeln,
  key ekp.ebelp,
      ekp.matnr,
      mkt.maktx,
      ekp.werks,
      ekp.lgort,
      ekp.meins,
      lfa.lifnr,
      lfa.name1,

      concat_with_space( lfa.stras, lfa.mcod3, 1 ) as satici_adresi


}
