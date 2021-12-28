module Services
  class UsersReport
    def self.call
      new.call
    end

    def call
      package = Axlsx::Package.new
      workbook = package.workbook
      sheet = worksheets(workbook)

      3.times do |row|
        sheet.add_row ["A#{row}", "B#{row}"]
      end

      package.to_stream.read
    end

    private

    def worksheets(workbook)
      first = workbook.add_worksheet(name: 'Первый')
      workbook.add_worksheet(name: 'Второй')
      workbook.add_worksheet(name: 'Третий')

      first
    end
  end
end
