
class Application
    @@items=[]
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            # split the path as a string and return only the last part
            item_name = req.path.split("/items/").last
            user_item = @@items.find{|item| item.name == item_name }
            if user_item
                resp.write "#{user_item.price}"
            else
                resp.write "Item not found"
                resp.status = 400
            end

        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end

end
