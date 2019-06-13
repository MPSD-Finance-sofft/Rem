class AccordDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: 'Accord.id', cond: :eq, searchable: true, orderable: true },
      state: { source: 'Accord.state', cond: :like, searchable: true, orderable: true },
      created_at: { source: 'Accord.created_at', cond: :like, searchable: true, orderable: true },
    }
  end

  def data
    records.decorate.map do |record|
      {
        id: record.id,
        state: record.state,
        created_at: record.created_at
      }
    end
  end

  def get_raw_records
    # insert query here
     Accord.all
  end

end
