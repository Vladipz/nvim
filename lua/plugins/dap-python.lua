return {

  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap"
  },
  ft = "python",
  config = function()
    local path =  "C:\\Users\\vladd\\.virtualenvs\\debugpy\\Scripts\\python.exe"
    require("dap-python").setup(path)
  end


}
