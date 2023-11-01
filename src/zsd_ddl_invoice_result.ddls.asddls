@AbapCatalog.sqlViewName: 'ZSD_V_INV_RESULT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item Result CDS Session 2'
define view ZSD_DDL_INVOICE_RESULT

  as select from ZSD_DDL_INVOICE_ITEM
{

  vbeln,
  sum( conversion_netwr )                                                             as total_netwr,
  kunnrAd,
  count( * )                                                                          as total_inv,
  division( cast( sum(conversion_netwr) as netwr), cast ( count(*) as abap.int4 ), 2) as avg_netwr,
  substring( fkdat, 1, 4 )                                                            as fkdat_years,
  substring( fkdat, 5, 2 )                                                            as fkdat_mount,
  substring( fkdat, 7, 2 )                                                            as fkdat_day,
  substring( inco2_l, 1, 3 )                                                          as inco2_l
  

}

group by
  vbeln,
  kunnrAd,
  fkdat,
  inco2_l
