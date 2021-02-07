module WineriesHelper

    def url_checker(url)
        /^http/i.match(url) ? url : "http://#{url}"
      end
end
