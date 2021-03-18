module Coingecko
  class Request
    class << self
      def where(resource_path, query = {}, options = {})
        response, status = get_json(resource_path, query)
        [200].include?(status) ? response : errors(status, response || {})
      end

      def get(uri)
        response, status = get_json(uri)
        [200].include?(status) ? response : errors(status, response || {})
      end

      def post(id, body)
        response, status = post_json(id, body)
        [200, 202].include?(status) ? [response, status] : errors(status, response || {})
      end

      def put(id, body)
        response, status = put_json(id, body)
        [200].include?(status) ? response : errors(status, response || {})
      end

      def errors(status, response)
        error = {errors: {status: status, message: response}}
        response.merge(error)
      end

      def get_json(root_path, query = {})
        query_string = query.map { |k, v| "#{k}=#{v}" }.join("&")
        path = query.empty? ? root_path : "#{root_path}?#{query_string}"
        response = api.get(path)
        [JSON.parse(response.body), response.status]
      end

      def post_json(root_path, query = {}, body)
        query_string = query.map { |k, v| "#{k}=#{v}" }.join("&")
        path = query.empty? ? root_path : "#{root_path}?#{query_string}"
        response = api.post(path, body)
        resp = !response.body.blank? ? JSON.parse(response.body) : nil
        [resp, response.status]
      end

      def put_json(root_path, query = {}, body)
        query_string = query.map { |k, v| "#{k}=#{v}" }.join("&")
        path = query.empty? ? root_path : "#{root_path}?#{query_string}"
        response = api.put(path, body)
        resp = !response.body.blank? ? JSON.parse(response.body) : nil
        [resp, response.status]
      end

      def api
        Coingecko::Connection.api
      end
    end
  end
end