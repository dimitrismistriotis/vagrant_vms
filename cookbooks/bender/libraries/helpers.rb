module AnotherOhMyZsh
  def dl_oh_my_and_create_rc_files()
	Dir.foreach("/home/") { |d|
    	if d != ".." && d != "." && d != "lost+found" && d != "vagrant" && d != "aquota.user"
          oh_my_zsh_location = "/home/#{d}/.oh-my-zsh"
	  unless File.directory? oh_my_zsh_location
		command_to_exec = "git clone https://github.com/robbyrussell/oh-my-zsh.git #{oh_my_zsh_location}"
		puts command_to_exec
		exec command_to_exec
	   end
	   zshrc_location = "/home/#{d}/.zshrc"
	   unless File.exists?(zshrc_location) 
	      exec "cp /home/#{d}/.oh-my-zsh/templates/zshrc.zsh-template /home/#{d}/.zshrc"
	   end
	end
	}
  end

  module_function :dl_oh_my_and_create_rc_files
end
