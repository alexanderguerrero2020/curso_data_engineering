{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='_row',

      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
        )
}}

select * from {{ source('google_sheets', 'budget') }}
 WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ source('google_sheets', 'budget') }})

{% endsnapshot %}