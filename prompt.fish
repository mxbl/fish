
### / Git functions /

function git_branch_name --description "Print the currents branch name"
  printf '%s' (git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function git_is_dirty
  printf '%s' (git status -s --ignore-submodules=dirty 2>/dev/null)
end

function git_commit_hash
  printf '%s' (git log --pretty=format:'%h' -n 1 2>/dev/null)
end

function git_commit_message
  set msg (git log -1 --pretty=%B 2>/dev/null | head -n1)
  printf "/%s.../" (string sub -l $argv[1] $msg) 
end

function git_status
  set -l git_branch (git_branch_name)

  if test -n "$git_branch"
    if [ (git_is_dirty) ]
      for i in (git branch -qv --no-color | string match -r '\*' | cut -d' ' -f4- | cut -d] -f1 | tr , \n)\
        (git status --porcelain | cut -c 1-2 | uniq)
        switch $i
          case "*[ahead *"
            set git_status "$git_status"(set_color ff3333)⬆
          case "*behind *"
            set git_status "$git_status"(set_color ff3333)⬇
          case "."
            set git_status "$git_status"(set_color 32cd32)✚
          case " D"
            set git_status "$git_status"(set_color ff3333)✖
          case "*M*"
            set git_status "$git_status"(set_color 32cd32)✱
          case "*R*"
            set git_status "$git_status"(set_color purple)➜
          case "*U*"
            set git_status "$git_status"(set_color brown)═
          case "??"
            set git_status "$git_status"(set_color ff3333)≠
        end
      end
    end

    # status:branch
    printf '%s%s'  (set_color -o)     "$git_status"
    printf '%s:'   (set_color 444444)
    printf '%s%s ' (set_color purple) "$git_branch"

    # commit hash
    printf '%s%s' (set_color ff8800)(git_commit_hash)

    # commit message
    if test (tput cols) -ge 50
      set msg_len \
        (math (tput cols) - (string length (current_working_directory)) - 25)
      printf '%s%s' (set_color 444444)(git_commit_message $msg_len)
    end

  else
    return
  end
end

### / Helper functions /

function current_working_directory
  # Calculate the current working directory in dependence of the base
  # git directory we in
  if [ (git_branch_name) ]
    set -l this_dir (pwd)

    # equals "" in case of a bare repo
    set -l git_dir (git rev-parse --show-toplevel)
    if not test -n "$git_dir"
      set git_dir (git rev-parse --git-dir)
    end

    if begin ; test $git_dir = $this_dir ; or test $git_dir = "." ; end
      echo (string split -r -m1 / $this_dir)[2]
    else
      set git_dir (string split -r -m1 / $git_dir)[1]
      string sub -s2 (string replace $git_dir "" $this_dir)
    end
  else
    prompt_pwd
  end
end

### / Main prompt function /

function fish_prompt --description 'Write out the prompt'
  set laststatus $status

  if [ (git_branch_name) ]
      printf '\n'
  else
      printf '%s%s: ' (set_color -o ff8800)(hostname)
  end

  # current working directory
  printf '%s%s ' (set_color -o white)(current_working_directory)

  git_status

  printf '%s' (set_color normal)

  # put the prompt on the next line if there is all the git information
  if [ (git_branch_name) ]
    printf "\n"
  end

  if test $laststatus -ne 0
    printf "%s%s-%s%s " (set_color -o red) "✘" "$laststatus" \
      (set_color normal)
  end

  printf "%s❯%s " (set_color -o cyan) (set_color normal)
end


### / Right prompt /

function fish_right_prompt
  #printf "%s❮%s " (set_color -o cyan) (set_color normal)
  #if test (tput cols) -ge 80
  #  printf '%s' (set_color 444444)
  #  printf '%s ❮' (history -1)
  #end
end

### / Vi mode prompt /

# remove the vi mode prompt on the left side
function fish_mode_prompt
end
