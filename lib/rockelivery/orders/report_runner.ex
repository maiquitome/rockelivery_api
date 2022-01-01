defmodule Rockelivery.Orders.ReportRunner do
  use GenServer

  require Logger

  alias Rockelivery.Orders.Report

  # Client

  def start_link(_initial_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  # Server

  @impl true
  def init(state) do
    Logger.info("Report Runner started")

    schedule_report_generation()

    {:ok, state}
  end

  @impl true
  # handle_info recebe qualquer tipo de mensagem
  def handle_info(:generate, state) do
    Logger.info("Generating report...")

    Report.create()
    schedule_report_generation()

    {:noreply, state}
  end

  def schedule_report_generation do
    # GERAR O RELATÓRIO UMA VEZ POR SEMANA
    # 7 dias * 24 horas = 168 horas
    # 168 horas * 60 = 10080 minutos
    # 10080 minutos * 60 = 604800 segundos
    # 604800 segundos * 1000 = 604800000 milissegundos

    # Process.send_after(self(), :generate, 168 * 60 * 60 * 1000)

    # GERAR O RELATÓRIO DE 10 EM 10 SEGUNDOS
    # 10 segundos * 1000 = 10000 milissegundos
    Process.send_after(self(), :generate, 10 * 1000)
  end
end
