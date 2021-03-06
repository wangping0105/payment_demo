class Api::V1::VersionsController < Api::V1::BaseController
  skip_before_action :authenticate!, :authenticate_app!

  def lastest_version
    param! :device, String, required: true, in: ['android', 'ios']

    app_version = AppVersion.where(app_type: AppVersion::app_types[params[:device]]).last
    app_version = init_version unless app_version.present?

    response.headers['Access-Control-Allow-Origin'] = '*' #跨域问题
    render json: {
      code: 0,
      data: app_version.as_json
    }
  end

  private
  def init_version
    AppVersion.create(
        app_type: AppVersion::app_types[params[:device]],
        name: 'OnlinePay',
        version_name: '1.0.0',
        version_code: '1.0.0'
    )
  end
end
