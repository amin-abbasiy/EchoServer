module ServiceHelper
  def self.included(base)
    base.class_eval do
      include ::ActiveModel::Validations

      def self.call(**args)
        args.each_pair do |key, value|
          self.instance_variable_set(key.to_sym, value)
        end
      end

      def call; end;
    end
  end
end
