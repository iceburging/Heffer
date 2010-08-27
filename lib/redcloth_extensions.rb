require 'redcloth'
require 'erb'

module RedCloth::Formatters::HTML
  def partial(opts)
    content = File.read(File.join(RAILS_ROOT,'app','views','public_partials',"_#{opts[:text]}.html.erb")) || "cannot find public_partials/_#{opts[:text]}.html.erb partial"
    erb = ERB.new(content)
    erb.result(binding)
  end

  def image(opts)

    if opts.key?(:text)
      opts[:text].gsub!(/\((.+)\)/, '')
      alt = ($~[1] rescue nil)
      opts[:text].gsub!(/^(&gt;|&lt;)?/, '')
      case ($~[1] rescue nil)
      when '&lt;'
        align = ' style="float:left; padding-right: 20px;"'
      when '&gt;'
        align = ' style="float:right; padding-left: 20px;"'
      else
        align = ''
      end
      src = opts[:text]
    else
      src = opts[:src]
      alt = opts[:title]
      align = ''
    end

    if src.include?('.')
     if alt.nil?
       %Q{<img#{align} src="#{src}" />}
     else
       %Q{<img#{align} src="#{src}" alt="#{alt}" />}
     end
    else
      image = Image.find_by_tag(src)
      if !image.nil?
        %Q{<img#{align} alt="#{image.title}" src="/private/site_content/images/#{image.id}/standard.png" />}
      else
        %Q{<img#{align} src="" alt="sorry image cannot be found" />}
      end
    end
  end

end

module RedClothInlineExtensions
  def refs_site_reference(text)
    text.gsub!(/:~(\S+)/) do |m|
      ref = $~[1]
      page = Page.find_by_permalink(ref)
      if !page.nil?
        link = %Q{:/#{page.menu_entry.permalink}/#{page.permalink}}
        result = link.gsub(' ','%20')
        result
      else
        product = ProductLine.find_by_prod_no(ref)
        unless product.nil?
          link = %Q{:/products/details/#{product.id}}
          result = link.gsub(' ','%20')
          result
        end
      end
    end
  end
end

RedCloth.send(:include, RedClothInlineExtensions)

