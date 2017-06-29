class MmsResourcesController < ApplicationController
  before_action :set_mms_resource, only: [:show, :edit, :update, :destroy]

  # GET /mms_resources
  # GET /mms_resources.json
  def index
    @twilio_number = ENV['TWILIO_NUMBER']
    @files = MmsResource.all
  end

  # GET /mms_resources/1
  # GET /mms_resources/1.json
  def show
  end

  # GET /mms_resources/new
  def new
    @mms_resource = MmsResource.new
  end

  # GET /mms_resources/1/edit
  def edit
  end

  # POST /mms_resources
  # POST /mms_resources.json
  def create
    media_url = params[:MediaUrl0]
    file_type = params[:MediaContentType0]
    uri = URI.parse(media_url)
    filename = File.basename(uri.path)
    mediaItem = MmsResource.new(filename: "#{filename}#{file_extension(file_type)}")
    byebug
    IO.copy_stream(open(media_url), mediaItem.path)

    mediaItem.save
    message = num_media <= 0 ? 'Send us an image' : 'Thanks for the 1 images'
    response = Twilio::TwiML::MessagingResponse.new
    response.message message

    render xml: response.to_xml_str
  end

  # PATCH/PUT /mms_resources/1
  # PATCH/PUT /mms_resources/1.json
  def update
    respond_to do |format|
      if @mms_resource.update(mms_resource_params)
        format.html { redirect_to @mms_resource, notice: 'Mms resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @mms_resource }
      else
        format.html { render :edit }
        format.json { render json: @mms_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mms_resources/1
  # DELETE /mms_resources/1.json
  def destroy
    @mms_resource.destroy
    respond_to do |format|
      format.html { redirect_to mms_resources_url, notice: 'Mms resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_mms_resource
    @mms_resource = MmsResource.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mms_resource_params
    params.require(:mms_resource).permit(:filename)
  end

  def num_media
    params[:numMedia].to_i
  end

  def file_extension(media_type)
    Rack::Mime::MIME_TYPES.invert[media_type]
  end
end
