module Rack
  class Headercontrol
    VERSION = "0.0.2"
    
    def initialize(app, &config_block)
      @app = app
      @config_block = config_block
    end
    
    def call(env)
      @app.call(env).tap do |response|
        @recorder = PathRecorder.new
        @config_block.call(@recorder)
        request = Rack::Request.new(env)
        response_headers = Utils::HeaderHash.new(response[1])
        @recorder.each do |condition, action|
          if request.path.match condition
            action.call(response_headers)
          end
        end
        response[1] = response_headers
      end
    end
  end
  HeaderControl = Headercontrol #Backwards-compatibility
  
  class PathRecorder
    def initialize
      @paths = {} 
    end
    
    def path(path, &block)
      @paths[path] = block
    end
    
    def [](path)
      @paths[path]
    end
    
    def each(&block)
      @paths.each(&block)
    end
  end
end
