module KeySelector
  SEPARATOR = "#-#-"

  def new_key(key, word)
    return SEPARATOR if word == "\n"

    word or key
  end
end
