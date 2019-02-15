view: sr_daily_test {
  derived_table: {
    sql: select
           date_part(week,created_at) as Weeknr
          ,date_part(DAYOFWEEK,created_at) as day
          ,count(id) as SRs
      from
      nl_mysql_werkspot.servicerequest
      where
      date(created_at) between date(DATEADD(DAY,-14,CURRENT_DATE)) and date(CURRENT_DATE)
      and status = 'PUBLISHED'
      group by
           date_part(week,created_at)
          ,date_part(DAYOFWEEK,created_at)
      order by 1,2
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: weeknr {
    type: number
    sql: ${TABLE}.weeknr ;;
  }

  dimension: day {
    type: number
    sql: ${TABLE}.day ;;
  }

  measure: srs {
    type: count
    sql: ${TABLE}.srs ;;
  }

  set: detail {
    fields: [weeknr, day, srs]
  }
}
