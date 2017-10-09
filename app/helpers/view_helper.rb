module ViewHelper
  def globalResources(key,source,*others)
    case source
      when 'article' then
        値1と一致する場合に行う処理
      when 'evaluates' then
        値2と一致する場合に行う処理
      when 値3 then
        値3と一致する場合に行う処理
      else
        どの値にも一致しない場合に行う処理
    end
  end
end
