class CsvExporter

  # Params :
  #   headers_map : {0 => 3, 2 => 1}
  #   target_headers_labels ["First Name", "Last Name", 'Age']
  def self.export_as_array(source_file, headers_map, target_headers_labels)
    result = []

    target_headers, source_matrix = map_matrix(headers_map, target_headers_labels)

    result << target_headers    # ["Last Name", "Age"]
    csv = if source_file.is_a?(FileUploader)
            data = CSV.parse(source_file.file.read)
            data.shift
            data
          else
            CSV.new(source_file)
            csv.shift # skip the header
          end

    csv.each do |source_row|
      result << source_matrix.map{|idx| source_row[idx]}
    end
    result
  end

  # OPTIM : don't use intermediary in-memory array
  def self.export_as_string(source_file, headers_map, target_headers_labels, col_sep=',', row_rep = "\n")
    result = ''
    export_as_array(source_file, headers_map, target_headers_labels).each_with_index do |row, idx|
      result << row_rep unless idx == 0
      result << row.join(col_sep)
    end
    result
  end

  def self.map_matrix(headers_map, target_headers)
    # input  : {0 => 3, 2 => 1}, ["Last Name", "First Name", 'Age']
    source_columns_to_read = headers_map.sort.map(&:last) # [3, 1]
    target_headers         = headers_map.sort.map(&:first).
                                    map{|idx| target_headers[idx]}
    [target_headers, source_columns_to_read]
  end
end
