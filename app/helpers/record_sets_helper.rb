module RecordSetsHelper
  def supports_dnd
    if browser.ie6? or browser.ie7? or browser.ie8? or browser.ie9? 
      return false
    else
      return true
    end
  end
end
