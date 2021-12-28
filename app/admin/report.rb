ActiveAdmin.register_page 'Отчет' do
  action_item :export_users do
    link_to 'Статистика', admin_otchet_report_path, method: :post
  end

  page_action :report, method: :post do
    # package = Axlsx::Package.new
    # workbook = package.workbook
    # first = workbook.add_worksheet(name: 'Первый')
    # second = workbook.add_worksheet(name: 'Второй')
    # third = workbook.add_worksheet(name: 'Третий')
    # 3.times do |row|
    #   first.add_row ["A#{row}", "B#{row}"]
    # end
    send_data Services::UsersReport.call,
              type: 'application/octet-stream',
              filename: 'user.xlsx'
  end

    # report_build_result = Operations::UsersReports::Build.call

    # send_file report_build_result.value[:report_file],
    #           type:        'application/octet-stream',
    #           disposition: 'attachment',
    #           filename:    'users.xlsx'

  # page_action :export_requests, method: :post do
  #   report = params['requests_filter']
  #   date_from = Time.zone.local(
  #     report['from(1i)'].to_i,
  #     report['from(2i)'].to_i,
  #     report['from(3i)'].to_i,
  #     0, 0
  #   )
  #   date_to = Time.zone.local(
  #     report['to(1i)'].to_i,
  #     report['to(2i)'].to_i,
  #     report['to(3i)'].to_i,
  #     23, 59
  #   )
  #   report_params = {
  #     date_from: date_from,
  #     date_to: date_to
  #   }

  #   send_data Operations::Report::Create.call(report_params).value,
  #             type: 'application/xlsx',
  #             disposition: 'attachment',
  #             filename: 'requests_report.xlsx'
  # end

  # content title: proc { I18n.t('active_admin.reports') } do
  #   render partial: 'requests_filter'
  # end
end