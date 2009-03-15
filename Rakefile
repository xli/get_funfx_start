require 'cucumber/rake/task'

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "--format pretty"
end

namespace :fb do
  class FBSdks
    def fbsdk_root
      return ENV['FB_SDK_PATH'] if ENV['FB_SDK_PATH']
      fb32_root = '/Applications/Adobe Flex Builder 3/sdks/3.2.0'
      fb32_plugin_root = '/Applications/Adobe Flex Builder 3 Plug-in/sdks/3.2.0'
      unless path = [fb32_root, fb32_plugin_root].find {|path| File.exist?(path)}
        raise %{Couldn't find Flex Builder 3.2 sdks directory! Please set FB_SDK_PATH env variable to point to Flex SDK path (e.g.: FB_SDK_PATH=PATH_TO_AIR_SDK/sdks/3.2.0).}
      end
      path
    end

    def include_libs
      libs = ['frameworks/libs/automation.swc',
        'frameworks/libs/automation_agent.swc',
        'frameworks/libs/automation_dmv.swc',
        'frameworks/locale/en_US/automation_agent_rb.swc'
       ].collect{|lib| File.join(fbsdk_root, lib)}
      (libs << File.expand_path('libs/funfx-0.2.2.swc')).collect do |path|
        "-include-libraries #{path.inspect}"
      end.join(' ')
    end

    def compiler
      File.join(fbsdk_root, 'bin', 'mxmlc')
    end

    def locale
      '-locale en_US'
    end

    def output
      "-output #{File.expand_path('dist/todolist.swf').inspect}"
    end

    def source
      "-source-path #{File.expand_path('src').inspect}"
    end

    def target_app_file
      File.expand_path(File.join('src', 'todolist.mxml')).inspect
    end

    def debug_options
      '-debug=true -actionscript-file-encoding UTF-8'
    end

    #From http://livedocs.adobe.com/flex/3/html/help.html?content=compilers_15.html
    #Incremental compilation means that the compiler inspects your code, 
    #determines which parts of the application are affected by your changes, 
    #and only recompiles the newer classes and assets. The Flex compilers 
    #generate many compilation units that do not change between compilation 
    #cycles. It is possible that when you change one part of your application, 
    #the change might not have any effect on the bytecode of another.
    def incremental
      '-incremental=true'
    end

    def compile(dryrun=false)
      cmd = %{#{compiler.inspect} #{locale} #{debug_options} #{include_libs} #{source} #{output} -- #{target_app_file}}
      puts cmd
      unless dryrun
        `#{cmd}`
      end
    end
  end

  desc "compile application with debug options"
  task :compile do
    FBSdks.new.compile(ENV['DRYRUN'] == 'true')
  end
end

namespace :dist do
  desc "clean dist"
  task :clean do
    FileUtils.rm_rf File.expand_path('dist')
  end

  task :copy_app_html do
    runtime_app_html = File.expand_path File.join('src', 'todo.html')
    dist_app_html = File.expand_path File.join('dist', 'todo.html')
    FileUtils.cp runtime_app_html, dist_app_html
  end
end

desc "Rebuild app and run all features"
task :default => ['dist:clean', 'fb:compile', 'dist:copy_app_html', :features]

