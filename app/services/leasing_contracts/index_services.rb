module LeasingContracts
  class IndexServices
    def initialize(params)
      @template = params[:template]
    end

    def perform
      case @template
        when 'summary_of_payments'
          'leasing_contracts/index/summary_of_payments.slim'
      	else 'leasing_contracts/index/index.slim'
       end
    end
  end
end