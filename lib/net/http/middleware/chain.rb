module Net
  class HTTP
    module Middleware
      class Chain
        attr_accessor :stack

        def initialize(&block)
          @stack = []
          instance_eval(&block) if block_given?
        end

        def use(middleware, *args)
          stack << [middleware, args]
        end

        def call(request, body = nil, &on_finish)
          build_call_chain(stack.dup, on_finish).call(request, body)
        end

        private def build_call_chain(stack, on_finish)
          stack.reverse.reduce(FinalizeMiddleware.new(on_finish)) do |chain, current_middleware|
            klass, args = current_middleware
            klass.new(chain, *args)
          end
        end

        # Final middleware which will execute orig_request
        class FinalizeMiddleware
          def initialize(on_finish)
            @on_finish = on_finish
          end

          def call(_req, _body = nil)
            @on_finish.call
          end
        end
      end
    end
  end
end
