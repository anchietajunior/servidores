
class ServersController < ApplicationController
  before_action :set_server, only: %i[ show edit update destroy ]

  # GET /servers or /servers.json
  def index
    @servers = Server.all.order(created_at: :desc)
  end

  def index_pdf
    @servers = Server.all.order(created_at: :desc)

    pdf = Prawn::Document.new
    pdf.text "Lista de Servidores", size: 20, style: :bold
    pdf.move_down 20

    table_data = [ [ "Nome", "IP", "Região", "Criado em" ] ]
    @servers.each do |server|
      table_data << [
        server.name,
        server.ip,
        server.region.humanize,
        server.created_at.strftime("%d/%m/%Y")
      ]
    end

    pdf.table(table_data, header: true, row_colors: [ "F0F0F0", "FFFFFF" ])

    send_data pdf.render,
              filename: "servidores.pdf",
              type: "application/pdf",
              disposition: "attachment"
  end

  # GET /servers/1 or /servers/1.json
  def show
  end

  # GET /servers/new
  def new
    @server = Server.new
  end

  # GET /servers/1/edit
  def edit
  end

  # POST /servers or /servers.json
  def create
    @server = Server.new(server_params)

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: "Server was successfully created." }
        format.json { render :show, status: :created, location: @server }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servers/1 or /servers/1.json
  def update
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to @server, notice: "Server was successfully updated." }
        format.json { render :show, status: :ok, location: @server }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1 or /servers/1.json
  def destroy
    @server.destroy!

    respond_to do |format|
      format.html { redirect_to servers_path, status: :see_other, notice: "Server was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def server_params
      params.expect(server: [ :name, :ip, :region, :frabricated_at ])
    end
end
