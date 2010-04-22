class OrcController
  @status_bar
  @task_bar_icon
  @main_frame
  @app

  def register_task_bar_icon(task_bar_icon)
    @task_bar_icon = task_bar_icon
  end

  def task_bar_icon
    @task_bar_icon
  end

  def status_bar
    @status_bar
  end

  def register_status_bar(status_bar)
    @status_bar = status_bar
  end

  def set_status(message)
    @status_bar.push_status_text(message)
  end

  def register_main_frame(frame)
    @main_frame = frame
  end

  def start_app()
    # Creating App
    @app = MinimalApp.new.main_loop
  end

  def shutdown()
    @main_frame.destroy()
    @task_bar_icon.destroy()
  end

  def show()
    @main_frame.show()
    @main_frame.iconize(false)
  end

end