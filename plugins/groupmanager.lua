local function modadd(msg)

    -- superuser and admins only (because sudo are always has privilege)
if not is_admin(msg) then
return '🌟| _أنـت لـسـت الـمـطـور _ ⚙️'
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
 return '🌟| المجموعه بالتأكيد ☑️ تم تفعيلها'

end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      replay ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = '☑️',
          lock_tag = '❌',
          lock_spam = '☑️',
          lock_webpage = '☑️',
          lock_markdown = '❌',
          flood = '☑️',
          lock_bots = '☑️',
          lock_pin = '❌',
          welcome = '❌',
		  lock_join = '❌',
		  lock_edit = '❌',
		  lock_mention = '☑️',
		  num_msg_max = '5',
		  set_char = '40',
		  time_check = '2',
          },
   mutes = {
                  mute_forward = '☑️',
                  mute_audio = '❌',
                  mute_video = '❌',
                  mute_contact = '☑️',
                  mute_text = '❌',
                  mute_photo = '❌',
                  mute_gif = '❌',
                  mute_location = '☑️',
                  mute_document = '❌',
                  mute_sticker = '❌',
                  mute_voice = '❌',
				  mute_keyboard = '❌',
				  mute_game = '❌',
				  mute_inline = '❌',
				  mute_tgservice = '❌',
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)

return '🌟| ☑️ تـم تـفـعـيـل الـمـجـمـوعـه ☑️'

end

local function modrem(msg)

    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then

        return '🌟| _أنـت لـسـت الـمـطـور _ ⚙️'
    
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
    return '🌟| المجموعه بالتأكيد ☑️ تم تعطيلها'
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)

 return '🌟| ⚠️تـم تـعـطـيـل الـمـجـمـوعـه⚠️'

end

local function filter_word(msg, word)

local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then

 return  "🌟| _ الكلمه_ *"..word.."* _هي بالتأكيد من قائمه المنع☑️_"
    
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)

 return  "🌟| _ الكلمه_ *"..word.."* _تمت اضافتها الى قائمه المنع ☑️_"
    
end

local function unfilter_word(msg, word)

 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
    
return  "🌟| _ الكلمه_ *"..word.."* _تم السماح بها ☑️_"
     
      else

      return  "🌟| _ الكلمه_ *"..word.."* _هي بالتأكيد مسموح بها☑️_"
      
   end
end

local function modlist(msg)

    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then

    return  "🌟| _هذه المجموعه ليست من حمايتي ☑️_"
  
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way

return  "🌟| _لا يوجد ادمن في هذه المجموعه ☑️_"
  
end

   message = '🌟| *قائمه الادمنيه :*\n'

  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)

    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
return  "🌟| _هذه المجموعه ليست من حمايتي ⚙️_"
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
return  "🌟| _ لا يوجد هنا مدير ⚙️_"
end
   message = '🌟| *قائمه المدراء :*\n'
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)

local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then

return tdcli.sendMessage(data.chat_id_, "", 0, "🌟| _هذه المجموعه ليست من حمايتي ⚙️_", 0, "md")
     
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..']\n🌟| _ الايدي _*['..data.id_..']*\n🌟| _ انه بالتأكيد من القائمه البيضاء ☑️ _', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _ تمت ترقيته ليصبح ضمن القائمه البيضاء ☑️_', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..']\n🌟| _ الايدي _*['..data.id_..']*\n🌟| _ انه بالتأكيد ليس من القائمه البيضاء ☑️ _', 0, "md")
       
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟|_ تمت تنزيله من القائمه البيضاء ☑️_', 0, "md")
   end

tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..']\n🌟| _ الايدي _*['..data.id_..']*\n🌟|_ انه بالتأكيد مدير ☑️ _', 0, "md")
      end
   
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟|_ تمت ترقيته ليصبح مدير ☑️_', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟|_ الايدي _*['..data.id_..']*\n🌟|_ انه بالتأكيد ادمن ☑️_', 0, "md")
      end
   
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي _*['..data.id_..']*\n🌟| _ تمت ترقيته ليصبح ادمن ☑️_', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _انه بالتأكيد ليس مدير ☑️_', 0, "md")
      end
   
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _تم تنزيله من الاداره ☑️_', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي _*['..data.id_..']*\n🌟| _انه بالتأكيد ليس ادمن ☑️_', 0, "md")
      
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي_ *['..data.id_..']*\n🌟| _تم تنزيله من الادمنيه ☑️_', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "ايدي" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else

  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      
   end
end

local function action_by_username(arg, data)

local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then

    return tdcli.sendMessage(data.chat_id_, "", 0, "🌟| _هذه المجموعه ليست من حمايتي ⚙️", 0, "md")
     
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..']\n🌟| _ الايدي _*['..data.id_..']*\n🌟|_ انه بالتأكيد من القائمه البيضاء ☑️ _', 0, "md")
      end
   
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _ تمت ترقيته ليصبح ضمن القائمه البيضاء ☑️_', 0, "md")
   
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..']\n🌟| _ الايدي _*['..data.id_..']*\n🌟| انه بالتأكيد ليس من القائمه البيضاء ☑️ _', 0, "md")
      
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| تمت تنزيله من القائمه البيضاء ☑️_', 0, "md")
   
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..']\n🌟| _ الايدي _*['..data.id_..']*\n🌟| _ انه بالتأكيد مدير ☑️ _', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _ تمت ترقيته ليصبح مدير ☑️_', 0, "md")
   
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي _*['..data.id_..']*\n🌟| _ انه بالتأكيد ادمن ☑️_', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي _*['..data.id_..']*\n🌟| _ تمت ترقيته ليصبح ادمن ☑️_', 0, "md")
   
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _انه بالتأكيد ليس مدير ☑️_', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _تم تنزيله من الاداره ☑️_', 0, "md")
   
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي _*['..data.id_..']*\n🌟| _انه بالتأكيد ليس ادمن ☑️_', 0, "md")
   
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي_ *['..data.id_..']*\n🌟| _تم تنزيله من الادمنيه ☑️_', 0, "md")
   
end
   if cmd == "ايدي" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "معلومات" then

     text = " معلومات [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else

  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      
   end
end

local function action_by_id(arg, data)

local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then

    return tdcli.sendMessage(data.chat_id_, "", 0, "🌟| _هذه المجموعه ليست من حمايتي ⚙️", 0, "md")
     
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..']\n🌟| _ الايدي _*['..data.id_..']*\n🌟|_ انه بالتأكيد من القائمه البيضاء ☑️ _', 0, "md")
     
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _ تمت ترقيته ليصبح ضمن القائمه البيضاء ☑️_', 0, "md")
  
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..']\n🌟| _ الايدي _*['..data.id_..']*\n🌟|_ انه بالتأكيد ليس من القائمه البيضاء ☑️ _', 0, "md")
      
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
 
return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _ تمت تنزيله من القائمه البيضاء ☑️_', 0, "md")
   end

  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..']\n🌟| _ الايدي _*['..data.id_..']*\n🌟| _ انه بالتأكيد مدير ☑️ _', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _ تمت ترقيته ليصبح مدير ☑️_', 0, "md")
   
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي _*['..data.id_..']*\n🌟| _ انه بالتأكيد ادمن ☑️_', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

   return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي _*['..data.id_..']*\n🌟| _ تمت ترقيته ليصبح ادمن ☑️_', 0, "md")
   
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _انه بالتأكيد ليس مدير ☑️_', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _الايدي_ *['..data.id_..']*\n🌟| _تم تنزيله من الاداره ☑️_', 0, "md")
   
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟|_ الايدي _*['..data.id_..']*\n🌟| _انه بالتأكيد ليس ادمن ☑️_', 0, "md")
   end
  
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '🌟| _العضو_ ['..user_name..'] \n🌟| _ الايدي_ *['..data.id_..']*\n🌟| _تم تنزيله من الادمنيه ☑️_', 0, "md")
   
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
username = '*لايوجد*'
end
  
return tdcli.sendMessage(arg.chat_id, 0, 1, '🌟| _ الايدي_ *[ '..data.id_..' ]* \n🌟| _المعرف_ : '..username..'\n🌟| _الاسم_ : '..data.first_name_, 1)
   end
 else

  return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو لا يوجد_", 0, "md")
    
  end
else

  return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو لا يوجد_", 0, "md")
      
   end
end


---------------Lock replay-------------------
local function lock_replay(msg, data, target)
if not is_mod(msg) then
 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end
local replay = data[tostring(target)]["settings"]["replay"] 
if replay == "❌" then
return '🌟| _مرحبا عزيزي_ \n🌟| _الردود بالتاكيد تم ايقافه ☑️_'
else
data[tostring(target)]["settings"]["replay"] = "❌"
save_data(_config.moderation.data, data) 
return '🌟| _مرحبا عزيزي_ \n🌟| _تم ايقاف الردود  ☑️_'
end
end

local function unlock_replay(msg, data, target)
 if not is_mod(msg) then
 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end 
local replay = data[tostring(target)]["settings"]["replay"]
 if replay == "☑️" then
return '🌟| _مرحبا عزيزي_ \n🌟| _الردود بالتاكيد تم تشغيله ☑️_'
else 
data[tostring(target)]["settings"]["replay"] = "☑️"
save_data(_config.moderation.data, data) 
return '🌟| _مرحبا عزيزي_ \n🌟| _تم تشغيل الردود  ☑️_'
end
end

---------------Lock Link-------------------
local function lock_link(msg, data, target)

if not is_mod(msg) then
 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "☑️" then
return '🌟| _مرحبا عزيزي_ \n🌟| _الروابط بالتأكيد تم قفلها_ ☑️'
else
data[tostring(target)]["settings"]["lock_link"] = "☑️"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الروابط_ ☑️'

end
end

local function unlock_link(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الروابط بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["settings"]["lock_link"] = "❌" save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الروابط_ ☑️'

end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التاك(#) بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["settings"]["lock_tag"] = "☑️"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل التاك(#)_ ☑️'

end
end

local function unlock_tag(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
 
end
local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التاك(#) بالتأكيد تم فتحه_ ☑️'

else 
data[tostring(target)]["settings"]["lock_tag"] = "❌" save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح التاك(#)_ ☑️'
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 
if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التذكير بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["settings"]["lock_mention"] = "☑️"
save_data(_config.moderation.data, data)

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل التذكير_ ☑️'

end
end

local function unlock_mention(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
 
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التذكير بالتأكيد تم فتحه_ ☑️'

else 
data[tostring(target)]["settings"]["lock_mention"] = "❌" save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح التذكير _☑️'

end
end


---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التعديل بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["settings"]["lock_edit"] = "☑️"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل التعديل_ ☑️'

end
end

local function unlock_edit(msg, data, target)
if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "❌" then
return '🌟| _مرحبا عزيزي_ \n🌟| _التعديل بالتأكيد تم فتحه_ ☑️'
else 
data[tostring(target)]["settings"]["lock_edit"] = "❌" save_data(_config.moderation.data, data) 
return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح التعديل_ ☑️'
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الكلايش بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["settings"]["lock_spam"] = "☑️"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الكلايش_ ☑️'

end
end

local function unlock_spam(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
 
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الكلايش بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["settings"]["lock_spam"] = "❌" 
save_data(_config.moderation.data, data)

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الكلايش_ ☑️'

end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التكرار بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["settings"]["flood"] = "☑️"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل التكرار_ ☑️'

end
end

local function unlock_flood(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التكرار بالتأكيد تم فتحه_ ☑️'

else 
data[tostring(target)]["settings"]["flood"] = "❌" save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح التكرار_ ☑️'

end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _البوتات بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["settings"]["lock_bots"] = "☑️"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل البوتات_ ☑️'

end
end

local function unlock_bots(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _البوتات بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["settings"]["lock_bots"] = "❌" save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح البوتات_ ☑️'

end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الاضافه بالتاكيد تم قفلها  _ ☑️'

else
 data[tostring(target)]["settings"]["lock_join"] = "☑️"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الاضافه_ ☑️'

end
end

local function unlock_join(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الاضافه بالتاكيد تم فتحها  _ ☑️'

else 
data[tostring(target)]["settings"]["lock_join"] = "❌"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الاضافه_ ☑️'

end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الماركدوان بالتاكيد تم قفله _ ☑️'

else
 data[tostring(target)]["settings"]["lock_markdown"] = "☑️"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الماركدوان_ ☑️'

end
end

local function unlock_markdown(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الماركدوان بالتأكيد تم فتحه_ ☑️'

else 
data[tostring(target)]["settings"]["lock_markdown"] = "❌" save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الماركدوان_ ☑️'

end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الويب بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["settings"]["lock_webpage"] = "☑️"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الويب_☑️'

end
end

local function unlock_webpage(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الويب بالتأكيد تم فتحه_ ☑️'

else 
data[tostring(target)]["settings"]["lock_webpage"] = "❌"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الويب_ ☑️'

end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التثبيت بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["settings"]["lock_pin"] = "☑️"
save_data(_config.moderation.data, data) 

return "🌟| _مرحبا عزيزي_ \n🌟| _تم قفل التثبيت_☑️"

end
end

local function unlock_pin(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
  
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التثبيت بالتأكيد تم فتحه_ ☑️'

else 
data[tostring(target)]["settings"]["lock_pin"] = "❌"
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح التثبيت_ ☑️'

end
end
--------Mutes---------

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _المتحركه بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_gif"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل المتحركه_ ☑️'

end
end

local function unmute_gif(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
 if mute_gif == "❌" then
return '🌟| _مرحبا عزيزي_ \n🌟| _المتحركه بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_gif"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح المتحركه_ ☑️'

end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الالعاب بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_game"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الالعاب_ ☑️'

end
end

local function unmute_game(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
 
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"]
 if mute_game == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الألعاب بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_game"] = "❌"
 save_data(_config.moderation.data, data)

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الألعاب_ ☑️'

end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الانلاين بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_inline"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الانلاين_ ☑️'

end
end

local function unmute_inline(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
 if mute_inline == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الانلاين بالتأكيد تم فتحه_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_inline"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الانلاين_ ☑️'

end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 

if not is_mod(msg) then
 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == "☑️" then
return '🌟| _مرحبا عزيزي_ \n🌟| _الدرشه بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_text"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الدردشه_ ☑️'

end
end

local function unmute_text(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
 
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"]
 if mute_text == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الدردشه بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_text"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الدردشه_ ☑️'

end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الصور بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_photo"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الصور_ ☑️'

end
end

local function unmute_photo(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end
 
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
 if mute_photo == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الصور بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_photo"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الصور_ ☑️'

end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الفيديو بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_video"] = "☑️" 
save_data(_config.moderation.data, data)

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الفيديو_ ☑️'

end
end

local function unmute_video(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local mute_video = data[tostring(target)]["mutes"]["mute_video"]
 if mute_video == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الفيديو يالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_video"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الفيديو_ ☑️'
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _البصمات بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_audio"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل البصمات_ ☑️'

end
end

local function unmute_audio(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
 if mute_audio == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _البصمات بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_audio"] = "❌"
 save_data(_config.moderation.data, data)

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح البصمات_ ☑️'

end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الصوت بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_voice"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الصوت_ ☑️'
end

end

local function unmute_voice(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
 if mute_voice == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الصوت بالتأكيد تم فتحه_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_voice"] = "❌"
 save_data(_config.moderation.data, data)

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الصوت_ ☑️'

end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الملصقات بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_sticker"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الملصقات_ ☑️'

end
end

local function unmute_sticker(msg, data, target)

 if not is_mod(msg) then
 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
 if mute_sticker == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الملصقات بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_sticker"] = "❌"
 save_data(_config.moderation.data, data)

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الملصقات_ ☑️'
 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _جهات الاتصال بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_contact"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل جهات الاتصال_ ☑️'

end
end

local function unmute_contact(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
 if mute_contact == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _جهات الاتصال بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_contact"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح جهات الاتصال_ ☑️'

end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _التوجيه بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_forward"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل التوجيه_ ☑️'

end
end

local function unmute_forward(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
 if mute_forward == "❌" then
return '🌟| _مرحبا عزيزي_ \n🌟| _التوجيه بالتأكيد تم فتحها_ ☑️'
else 
data[tostring(target)]["mutes"]["mute_forward"] = "❌"
 save_data(_config.moderation.data, data)

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح التوجيه_ ☑️'
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الموقع بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_location"] = "☑️" 
save_data(_config.moderation.data, data)

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الموقع_ ☑️'

end
end

local function unmute_location(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end 

local mute_location = data[tostring(target)]["mutes"]["mute_location"]
 if mute_location == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الموقع بالتأكيد تم فتحه_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_location"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الموقع_ ☑️'

end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الملفات بالتأكيد تم قفلها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_document"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الملفات_ ☑️'

end
end

local function unmute_document(msg, data, target)

 if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end
 

local mute_document = data[tostring(target)]["mutes"]["mute_document"]
 if mute_document == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الملفات بالتأكيد تم فتحها_ ☑️'

else 
data[tostring(target)]["mutes"]["mute_document"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الملفات_ ☑️'

end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الاشعارات بالتأكيد تم فتحها_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_tgservice"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الاشعارات_ ☑️'
end
end

local function unmute_tgservice(msg, data, target)

 if not is_mod(msg) then
 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
 if mute_tgservice == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الاشعارات بالتأكيد تم فتحها_ ☑️'
else 
data[tostring(target)]["mutes"]["mute_tgservice"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _الاشعارات بالتأكيد تم فتحها_ ☑️'

end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard == "☑️" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الكيبورد بالتأكيد تم قفله_ ☑️'

else
 data[tostring(target)]["mutes"]["mute_keyboard"] = "☑️" 
save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الكيبورد_ ☑️'

end
end

local function unmute_keyboard(msg, data, target)

 if not is_mod(msg) then
 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"]
 if mute_keyboard == "❌" then

return '🌟| _مرحبا عزيزي_ \n🌟| _الكيبورد بالتأكيد تم فتحه_ ☑️'
 
else 
data[tostring(target)]["mutes"]["mute_keyboard"] = "❌"
 save_data(_config.moderation.data, data) 

return '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الكيبورد_ ☑️'
 
end
end
----------MuteList---------
local function mutes(msg, target) 	

if not is_mod(msg) then
 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"
end

local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)]["mutes"] then		

if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "����"		
end
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "❌"		
end
end

local mutes = data[tostring(target)]["mutes"]
 text = "🗯|<code> اعدادات الوسائط:</code>"
 .."\n🌟| قفل المتحركه : "..mutes.mute_gif
 .."\n🌟| قفل الدردشه : "..mutes.mute_text
 .."\n🌟| قفل الانلاين : "..mutes.mute_inline
 .."\n🌟| قفل الالعاب : "..mutes.mute_game
 .."\n🌟| قفل الصور : "..mutes.mute_photo
 .."\n🌟| قفل الفيديو : "..mutes.mute_video
 .."\n🌟| قفل البصمات : "..mutes.mute_audio
 .."\n🌟| قفل الصوت : "..mutes.mute_voice
 .."\n🌟| قفل الملصقات : "..mutes.mute_sticker
 .."\n🌟| قفل الجهات : "..mutes.mute_contact
 .."\n🌟| قفل التوجيه : "..mutes.mute_forward
 .."\n🌟| قفل الموقع : "..mutes.mute_location
 .."\n🌟| قفل الملفات : "..mutes.mute_document
 .."\n🌟| قفل الاشعارات : "..mutes.mute_tgservice
 .."\n🌟| قفل الكيبورد : "..mutes.mute_keyboard
 .."\n🌟| مطور الـسـورس : @TH3BOSS"
 .."\n🌟| قناه الـسـورس : @llDEV1ll \n"

return  tdcli.sendMessage(msg.to.id, msg.id, 0,text , 0, "html")
end

function group_settings(msg, target) 	

if not is_mod(msg) then

 return "🌟| _هذا الامر يخص الادمنيه فقط _ 🚶"

end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
	
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "☑️"		
end
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "☑️"		
end
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "☑️"		
end
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "☑️"		
end
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "☑️"		
end
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "❌"		
end
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_pin"] then			
data[tostring(target)]["settings"]["lock_pin"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_join"] then			
data[tostring(target)]["settings"]["lock_join"] = "❌"		
end
if not data[tostring(target)]["settings"]["replay"] then			
data[tostring(target)]["settings"]["replay"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_woring"] then			
data[tostring(target)]["settings"]["lock_woring"] = "❌"		
end
end

if data[tostring(target)]["mutes"] then		

if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "❌"		
end
end

 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
local day = math.floor(expi / 86400) + 1
if expi == -1 then
	expire_date = 'مفتوح🎖'
    elseif day == 1 then
	expire_date = 'يوم واحد' 
	elseif day == 2 then
   	expire_date = 'يومين'
	elseif day == 3 then
   	expire_date = '3 ايام'
   	else
	expire_date = day..' يوم'
end

local settings = data[tostring(target)]["settings"] 
local mutes = data[tostring(target)]["mutes"]

 list_mutes = "🗯|<code> اعدادات الوسائط:</code>"
 .."\n🌟| قفل المتحركه : "..mutes.mute_gif
 --.."\n🌟| قفل الدردشه : "..mutes.mute_text
 .."\n🌟| قفل الانلاين : "..mutes.mute_inline
 --.."\n🌟| قفل الالعاب : "..mutes.mute_game
 .."\n🌟| قفل الصور : "..mutes.mute_photo
 .."\n🌟| قفل الفيديو : "..mutes.mute_video
 .."\n🌟| قفل البصمات : "..mutes.mute_audio
 .."\n🌟| قفل الصوت : "..mutes.mute_voice
 .."\n🌟| قفل الملصقات : "..mutes.mute_sticker
 .."\n🌟| قفل الجهات : "..mutes.mute_contact
 .."\n🌟| قفل التوجيه : "..mutes.mute_forward
-- .."\n🌟| قفل الموقع : "..mutes.mute_location
-- .."\n🌟| قفل الملفات : "..mutes.mute_document
 .."\n🌟| قفل الاشعارات : "..mutes.mute_tgservice
-- .."\n🌟| قفل الكيبورد : "..mutes.mute_keyboard

.."\n\n🗯|<code> اعدادات اخرى :</code> "
.."\n🌟| تشغيل الترحيب : "..settings.welcome
.."\n🌟| تشغيل الردود : "..settings.replay
.."\n🌟| تشغيل التحذير : "..settings.lock_woring

 .." \n\n🌟| الاشتراك : "..expire_date
 .."\n🌟| مطور الـسـورس : @TH3BOSS"
 .."\n🌟| قناه الـسـورس : @llDEV1ll\n"

 list_settings = "🗯|<code> اعدادات المجموعه :</code> "
 .."\n🌟| قفل التعديل : "..settings.lock_edit
 .."\n🌟| قفل الروابط : "..settings.lock_link
 .."\n🌟| قفل الاضافه : "..settings.lock_join
 .."\n🌟| قفل التاك : "..settings.lock_tag
 .."\n🌟| قفل التكرار : "..settings.flood
-- .."\n🌟| قفل الكلايش : "..settings.lock_spam
 --.."\n🌟| قفل التذكير : "..settings.lock_mention
-- .."\n🌟| قفل الويب : "..settings.lock_webpage
-- .."\n🌟| قفل الماركدوان : "..settings.lock_markdown
 .."\n🌟| قفل التثبيت : "..settings.lock_pin
 .."\n🌟| قفل البوتات : "..settings.lock_bots
 .."\n🌟| عدد التكرار : "..NUM_MSG_MAX
-- .."\n🌟| عدد المده : "..SETCHAR
-- .."\n🌟| التكرار بالزمن : "..TIME_CHECK


return  tdcli.sendMessage(msg.to.id, 1, 0,list_settings.."\n\n"..list_mutes , 0, "html")
end

local function th3boss(msg, matches)

local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if matches[1] == "تفعيل" then
return modadd(msg)
end
if matches[1] == "تعطيل" then
return modrem(msg)
end
if not data[tostring(msg.to.id)] then return end
if matches[1] == "ايدي" then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
   if data.photos_[0] then
       	local rank
				if is_sudo(msg) then
					rank = 'المطور مالتي 😻'
				elseif is_owner(msg) then
					rank = 'مدير المجموعه 😽'
				elseif is_admin(msg) then
					rank = 'ادمن المجموعه 😼'
				elseif is_mod(msg) then
					rank = 'اداري المجموعه 😺'
				else
					rank = 'مجرد عضو 😹'
				end
tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'🌟| ايدي المجموعه : '..msg.to.id..'\n🌟| ايديك : '..msg.from.id..'\n🌟| رتبتك : '..rank..'\n',dl_cb,nil)
   else
tdcli.sendMessage(msg.to.id, msg.id_, 1, "🌟|لا يوجد صوره في بروفايلك ...!\n\n> *🌟| ايدي المجموعه :* `"..msg.to.id.."`\n*🌟| ايديك :* `"..msg.from.id.."`", 1, 'md')
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
end
if msg.reply_id and not matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="ايدي"})
  end
if matches[2] and is_mod(msg) then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ايدي"})
      end
   end
if matches[1] == "تثبيت" and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == '☑️' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)

return "🌟| _مرحبآ عزيزي_\n🌟| _ تم تثبيت الرساله_ ☑️"

elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == '❌' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)

return "🌟| _مرحبآ عزيزي_\n🌟| _ تم تثبيت الرساله_ ☑️"

end
end
if matches[1] == "الغاء التثبيت" and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == '☑️' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
return "🌟| _مرحبآ عزيزي_\n🌟| _ تم الغاء تثبيت الرساله_ ☑️"

elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == '❌' then
tdcli.unpinChannelMessage(msg.to.id)

return "🌟| _مرحبآ عزيزي_\n🌟| _ تم الغاء تثبيت الرساله_ ☑️"

end
end
if matches[1] == "القائمه البيضاء" and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end

if matches[1] == "رفع المدير" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if matches[1] == "تنزيل المدير" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if matches[1] == "رفع ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if matches[1] == "تنزيل ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if matches[1] == "قفل" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الروابط" then
return lock_link(msg, data, target)
end
if matches[2] == "التاك" then
return lock_tag(msg, data, target)
end
if matches[2] == "التذكير" then
return lock_mention(msg, data, target)
end
if matches[2] == "التعديل" then
return lock_edit(msg, data, target)
end
if matches[2] == "الكلايش" then
return lock_spam(msg, data, target)
end
if matches[2] == "التكرار" then
return lock_flood(msg, data, target)
end
if matches[2] == "البوتات" then
return lock_bots(msg, data, target)
end
if matches[2] == "الماركدوان" then
return lock_markdown(msg, data, target)
end
if matches[2] == "الويب" then
return lock_webpage(msg, data, target)
end
if matches[2] == "الثبيت" and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "الاضافه" then
return lock_join(msg, data, target)
end
end
if matches[1] == "فتح" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الروابط" then
return unlock_link(msg, data, target)
end
if matches[2] == "التاك" then
return unlock_tag(msg, data, target)
end
if matches[2] == "التذكير" then
return unlock_mention(msg, data, target)
end
if matches[2] == "التعديل" then
return unlock_edit(msg, data, target)
end
if matches[2] == "الكلايش" then
return unlock_spam(msg, data, target)
end
if matches[2] == "التكرار" then
return unlock_flood(msg, data, target)
end
if matches[2] == "البوتات" then
return unlock_bots(msg, data, target)
end
if matches[2] == "الماركوان" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "الويب" then
return unlock_webpage(msg, data, target)
end
if matches[2] == "التثبيت" and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "الاضافه" then
return unlock_join(msg, data, target)
end
end

if matches[1] == "قفل" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الكل" then
    local close_all ={
 mute_gif(msg, data, target),
 mute_text(msg ,data, target),
 mute_photo(msg ,data, target),
 mute_audio(msg ,data, target),
 mute_voice(msg ,data, target),
 mute_sticker(msg ,data, target),
 mute_forward(msg ,data, target),
 mute_contact(msg ,data, target),
 mute_location(msg ,data, target),
 mute_tgservice(msg ,data, target),
 mute_document(msg ,data, target),
 mute_game(msg ,data, target),
 lock_link(msg, data, target),
 lock_tag(msg, data, target),
 lock_mention(msg, data, target),
 lock_edit(msg, data, target),
 lock_spam(msg, data, target),
 lock_flood(msg, data, target),
 lock_bots(msg, data, target),
 lock_webpage(msg, data, target),
 lock_join(msg, data, target),
        
    }
return close_all,'🌟| _مرحبا عزيزي_ \n🌟| _تم قفل الكل _ ☑️' 
end
if matches[2] == "المتحركه" then
return mute_gif(msg, data, target)
end
if matches[2] == "الدردشه" then
return mute_text(msg ,data, target)
end
if matches[2] == "الصور" then
return mute_photo(msg ,data, target)
end
if matches[2] == "الفيديو" then
return mute_video(msg ,data, target)
end
if matches[2] == "البصمات" then
return mute_audio(msg ,data, target)
end
if matches[2] == "الصوت" then
return mute_voice(msg ,data, target)
end
if matches[2] == "الملصقات" then
return mute_sticker(msg ,data, target)
end
if matches[2] == "الجهات" then
return mute_contact(msg ,data, target)
end
if matches[2] == "التوجيه" then
return mute_forward(msg ,data, target)
end
if matches[2] == "الموقع" then
return mute_location(msg ,data, target)
end
if matches[2] == "الملفات" then
return mute_document(msg ,data, target)
end
if matches[2] == "الاشعارات" then
return mute_tgservice(msg ,data, target)
end
if matches[2] == "الانلاين" then
return mute_inline(msg ,data, target)
end
if matches[2] == "الالعاب" then
return mute_game(msg ,data, target)
end
if matches[2] == "الكيبورد" then
return mute_keyboard(msg ,data, target)
end
end
if matches[1] == "فتح" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الكل" then
    local open_all ={
 unmute_gif(msg, data, target),
 unmute_text(msg ,data, target),
 unmute_photo(msg ,data, target),
 unmute_audio(msg ,data, target),
 unmute_voice(msg ,data, target),
 unmute_sticker(msg ,data, target),
 unmute_forward(msg ,data, target),
 unmute_contact(msg ,data, target),
 unmute_location(msg ,data, target),
 unmute_tgservice(msg ,data, target),
 unmute_document(msg ,data, target),
 unmute_game(msg ,data, target),
 unlock_link(msg, data, target),
 unlock_tag(msg, data, target),
 unlock_mention(msg, data, target),
 unlock_edit(msg, data, target),
 unlock_spam(msg, data, target),
 unlock_flood(msg, data, target),
 unlock_bots(msg, data, target),
 unlock_webpage(msg, data, target),
 unlock_join(msg, data, target),
        
    }
return open_all, '🌟| _مرحبا عزيزي_ \n🌟| _تم فتح الكل _ ☑️' 
end
if matches[2] == "المتحركه" then
return unmute_gif(msg, data, target)
end
if matches[2] == "الدردشه" then
return unmute_text(msg, data, target)
end
if matches[2] == "الصور" then
return unmute_photo(msg ,data, target)
end
if matches[2] == "الفيديو" then
return unmute_video(msg ,data, target)
end
if matches[2] == "البصمات" then
return unmute_audio(msg ,data, target)
end
if matches[2] == "الصوت" then
return unmute_voice(msg ,data, target)
end
if matches[2] == "الملصقات" then
return unmute_sticker(msg ,data, target)
end
if matches[2] == "الجهات" then
return unmute_contact(msg ,data, target)
end
if matches[2] == "التوجيه" then
return unmute_forward(msg ,data, target)
end
if matches[2] == "الموقع" then
return unmute_location(msg ,data, target)
end
if matches[2] == "الملفات" then
return unmute_document(msg ,data, target)
end
if matches[2] == "الاشعارات" then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == "الانلاين" then
return unmute_inline(msg ,data, target)
end
if matches[2] == "الالعاب" then
return unmute_game(msg ,data, target)
end
if matches[2] == "الكيبورد" then
return unmute_keyboard(msg ,data, target)
end
end
if matches[1] == "المجموعه" and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)

ginfo = "🌟| _معلومات المجموعه :_\n🌟| _عدد الادمنيه _*["..data.administrator_count_.."]*\n🌟| _عدد الاعضاء _*["..data.member_count_.."]*\n🌟| _عدد المطرودين _*["..data.kicked_count_.."]*\n🌟| _ايدي المجموعه _*["..data.channel_.id_.."]*"
print(serpent.block(data))

        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if matches[1] == 'تغير الرابط' and is_mod(msg) then
			local function callback_link (arg, data)

    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)

       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*البوت ليس منشئ المجموعة قم بأضافة الرابط بأرسال* [ ضع رابط ]", 1, 'md')
    
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
  
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*🌟| _شكرأ لك 😻_\n🌟| _تم حفظ الرابط بنجاح _☑️ *", 1, 'md')
            
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
if matches[1] == "ضع رابط" and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)

return "🌟| _مرحبآ عزيزي_\n🌟| _رجائا ارسل الرابط الآن _🔃"
       
		end

if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)

return "🌟| _شكرأ لك 😻_\n🌟| _تم حفظ الرابط بنجاح _☑️"
		 	
       end
		end
		
if matches[1] == "الرابط" and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
 if not linkgp then
return "🌟| _اوه 🙀 لا يوجد هنا رابط_\n🌟| _رجائا اكتب [ضع رابط]_🔃"
      end
      text = "<b>رابط المجموعة  :</b>\n"..linkgp..msg_caption
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
     
if matches[1] == "الرابط خاص" and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
 
return "🌟| _اوه 🙀 لا يوجد هنا رابط_\n🌟| _رجائا اكتب [ضع رابط]_🔃"
      
      end
      tdcli.sendMessage(msg.from.id, 0, 1, "<code>🌟|رابـط الـمـجـمـوعه 💯\n🌟|"..msg.to.title.." :\n\n</code>"..linkgp..'\n', 1, 'html')
return "🌟| _مرحبآ عزيزي_\n🌟| _تم ارسال الرابط خاص لك _🔃"
        
     end

if matches[1] == "ضع قوانين" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)

return '🌟| _مرحبآ عزيزي_\n🌟| _تم حفظ القوانين بنجاح_☑️\n🌟| _اكتب [ القوانين ] لعرضها 💬_'
   
  end
  if matches[1] == "القوانين" then
 if not data[tostring(chat)]['rules'] then

     rules = "🌟| _مرحبأ عزيري_ 👋🏻 _القوانين كلاتي_ 👇🏻\n🌟| _ممنوع نشر الروابط_ \n🌟| _ممنوع التكلم او نشر صور اباحيه_ \n🌟| _ممنوع  اعاده توجيه_ \n🌟| _ممنوع التكلم بلطائفه_ \n🌟| _الرجاء احترام المدراء والادمنيه _😅\n🌟| _تابع _@verxbot 💤"
 
        else
     rules = "*🌟|القوانين :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if matches[1] == "معلومات" and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="معلومات"})
  end

		if matches[1] == "الاحرف" then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)

     return "_تم تعيين حساسية الأحرف إلى :_ *[ "..matches[2].." ]*"
	
  end
  if matches[1] == "ضع تكرار" and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "🌟| _حدود التكرار ,  يجب ان تكون ما بين _ *[2-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)

    return "_🌟| تم  وضع الكرار :_ *[ "..matches[2].." ]*"
    
       end
  if matches[1] == "ضع تكرار بالزمن" and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "🌟| _حدود التكرار ,  يجب ان تكون ما بين _ *[2-10]*"
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)

    return "_🌟|تم وضع التكرار :_ *[ "..matches[2].." ]*"
    
       end
		if matches[1] == "مسح" and is_owner(msg) then
			if matches[2] == "الادمنيه" then
				if next(data[tostring(chat)]['mods']) == nil then

return "🌟| _اوه ☢ هنالك خطأ_ 🚸\n🌟| _عذرا لا يوجد ادمنيه ليتم مسحهم_ ☑️"
				
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
 
return "🌟| _مرحبآ عزيزي_ \n🌟| _تم حذف الادمنيه بنجاح_ ☑️"
			
         end
			if matches[2] == "قائمه المنع" then
				if next(data[tostring(chat)]['filterlist']) == nil then

					return "🌟| _اوه ☢ هنالك خطأ_ 🚸\n🌟| _عذرا لا توجد كلمات ممنوعه ليتم حذفها_ ☑️"
             
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end

				return "🌟| _مرحبآ عزيزي_ \n🌟| _تم حذف الكلمات الممنوعه بنجاح_ ☑️"
           
			end
			if matches[2] == "القوانين" then
				if not data[tostring(chat)]['rules'] then
         					

return "🌟| _اوه ☢ هنالك خطأ_ 🚸\n🌟| _عذرا لا يوجد قوانين ليتم مسحه_ ☑️"
             
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)

return "🌟| _مرحبآ عزيزي_ \n🌟| _تم حذف القوانين بنجاح_ ☑️"
			
       end
			if matches[2] == "الترحيب"  then
				if not data[tostring(chat)]['setwelcome'] then
    
return "🌟| _اوه ☢ هنالك خطأ_ 🚸\n🌟| _عذرا لا يوجد ترحيب ليتم مسحه_ ☑️"
             
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)

return "🌟| _مرحبآ عزيزي_ \n🌟| _تم حذف الترحيب بنجاح_ ☑️"
			
       end
			if matches[2] == "الوصف" then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then

return "🌟| _اوبس ☢ هنالك خطأ_ 🚸\n🌟| _عذرا لا يوجد وصف ليتم مسحه_ ☑️"
          
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end

return "🌟| _مرحبآ عزيزي_ \n🌟| _تم حذف الوصف بنجاح_ ☑️"
             
		   	end
        end
		if matches[1] == "مسح" and is_admin(msg) then
			if matches[2] == "المدراء" then
				if next(data[tostring(chat)]['owners']) == nil then

return "🌟| _اوبس ☢ هنالك خطأ_ 🚸\n🌟| _عذرا لا يوجد مدراء ليتم مسحهم_ ☑️"
            
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end

            return "🌟| _مرحبآ عزيزي_ \n🌟| _تم حذف المدراء بنجاح_ ☑️"
          
			end
     end
if matches[1] == "ضع اسم" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if matches[1] == "ضع وصف" and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end

     return "🌟| _تم وضع الوصف بنجاح_☑️"
      
  end
  if matches[1] == "الوصف" and msg.to.type == "chat" and is_owner(msg) then
 if not data[tostring(chat)]['about'] then

      about = "🌟| _لا يوجد وصف ليتم عرضه _☑️*"
       
        else
     about = "🌟| *وصف المجموعة :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if matches[1] == "منع" and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1] == "الغاء منع" and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if matches[1] == "قائمه المنع" and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1] == "الحمايه" and is_mod(msg) then
return group_settings(msg, target)
end
if matches[1] == "الوسائط" and is_mod(msg) then
return mutes(msg, target)
end
if matches[1] == "الادمنيه" and is_mod(msg) then
return modlist(msg)
end
if matches[1] == "المدراء" and is_owner(msg) then
return ownerlist(msg)
end
if matches[1] == "القائمه البيضاء" and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end

if matches[1] == "اختيار" and is_mod(msg) then
local function found_helper(TM, Beyond)
local function inline_query_cb(TM, BD)
      if BD.results_ and BD.results_[0] then
		tdcli.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, BD.inline_query_id_, BD.results_[0].id_, dl_cb, nil)
    else
 
    text = "_المساعد غير متواجد حاليا_\n\n"
    
  return tdcli.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
   end
end
tdcli.getInlineQueryResults(Beyond.id_, msg.to.id, 0, 0, msg.to.id, 0, inline_query_cb, nil)
end
tdcli.searchPublicChat(tostring(helper_username), found_helper, nil)
end




if matches[1] == "الاوامر" and is_mod(msg) then

text = [[
 🗯¦ لسته اوامر سأورس الـزعـيم V16
 
➖🔸➖🔹➖🔸➖🔹➖🔸

🌟| تفعيل | تعطيل - لتفعيل البوت او تعطيل
🌟| تشغيل | ايقاف - لتفعيل التحذير او تعطيل
🌟| تشغيل | ايقاف - لتفعيل ا او لردودتعطيل
🌟| رفع مطور - لرفع مطور
🌟| تنزيل مطور - لتنزيل مطور
🌟| رفع المدير - لرفع مدير
🌟| تنزيل المدير - لتنزيل مدير
🌟| رفع اداري - لرفع اداري
🌟| تنزيل اداري - لتنزيل اداري
🌟| رفع ادمن - لرفع ادمن
🌟| تنزيل ادمن - لتنزيل ادمن
🌟| قائمه المدراء | قائمه الادمنيه
🌟| حظر عام | الغاء العام - لحظر العام او الالغاء
🌟| حظر | دي | الغاء الحظر 
🌟| كتم | الغاء الكتم | مسح الكل - كتم العضو او مسح كل رسائله
🌟| قائمه الكتم | قائمه الحظر - لعرض القوائم
🌟| تثبيت - لتثبيت الرسائل
🌟| الغاء تثبيت - لالغاء تثبيت الرسائل
🌟| ايدي | موقعي  - لعرض موقعك او الايدي
🌟| قائمه المنع | الحمايه | الوسائط - لرويه ملحقات الحماية والحمايه

➖🔸➖🔹➖🔸➖🔹➖🔸

🌟| قفل ~ للقفل و فتح ~ للفتح 
 
🌟| التوجيه | المتحركه | الدردشه | البصمات 
🌟| الجهات | الملصقات | الصوت | الفيديو | الصور

➖🔸➖🔹➖🔸➖🔹➖🔸

🌟|  قفل ~ للقفل و فتح ~ للفتح 
 
🌟| الروابط | التثبيت | التاك | التذكير | التعديل 
🌟| الكلايش | التكرار | البوتات | الماركدوان | الانلاين | الكيبورد

➖🔸➖🔹➖🔸➖🔹➖🔸

🌟| مسح - قائمه الحظر | المدراء | الادمنيه | قائمه المنع | قائمه الكتم
🌟| الغاء منع - لحذف الكلمات الممنوعه
🌟| منع - لمنع الكلمات داخل المجموعه
🌟| قائمه المنع - لاضهار الكلمات الممنوعه
🌟| التكرار + العدد - لاضافه عدد التكرار
🌟| الرابط | ضع رابط | تغير الرابط 

➖🔸➖🔹➖🔸➖🔹➖🔸
‎🌟| مطور الـسـورس : @TH3BOSS
‎🌟| قناه الـسـورس : @llDEV1ll]]

return text
end
--------------------- Welcome -----------------------
if matches[1] == "تشغيل" and is_mod(msg) then
	    local target = msg.to.id
        if matches[2] == "الردود" then
return unlock_replay(msg, data, target)
end
if matches[2] == "الترحيب" then
			welcome = data[tostring(chat)]['settings']['welcome']
		if welcome == "☑️" then
return "🌟| _مرحبا عزيزي_\n🌟| _تشغيل الترحيب مفعل مسبقاً_ ☑️"
			else
		data[tostring(chat)]['settings']['welcome'] = "☑️"
	    save_data(_config.moderation.data, data)
return "🌟| _مرحبا عزيزي_\n🌟| _تم تشغيل الترحيب_ ☑️"
		end
	end
	if matches[2] == "التحذير" then
			lock_woring = data[tostring(chat)]['settings']['lock_woring']
		if lock_woring == "☑️" then
return "🌟| _مرحبا عزيزي_\n🌟| _تشغيل التحذير مفعل مسبقاً_ ☑️"
			else
		data[tostring(chat)]['settings']['lock_woring'] = "☑️"
	    save_data(_config.moderation.data, data)
return "🌟| _مرحبا عزيزي_\n🌟| _تم تشغيل التحذير_ ☑️"
		end
		end
		end
	if matches[1] == "ايقاف" and is_mod(msg) then
	    local target = msg.to.id
        if matches[2] == "الردود" then
        return lock_replay(msg, data, target)
        end
         if matches[2] == "الترحيب" then
    welcome = data[tostring(chat)]['settings']['welcome']
	if welcome == "❌" then
	return "🌟| _مرحبا عزيزي_\n🌟| _الترحيب بالتأكيد معطل_ ☑️"
			else
		data[tostring(chat)]['settings']['welcome'] = "❌"
	    save_data(_config.moderation.data, data)
return "🌟| _مرحبا عزيزي_\n🌟| _تم ايقاف الترحيب_ ☑️"
			end
end

      if matches[2] == "التحذير" then
    lock_woring = data[tostring(chat)]['settings']['lock_woring']
	if lock_woring == "❌" then
	return "🌟| _مرحبا عزيزي_\n🌟| _التحذير بالتأكيد معطل_ ☑️"
			else
		data[tostring(chat)]['settings']['lock_woring'] = "❌"
	    save_data(_config.moderation.data, data)
return "🌟| _مرحبا عزيزي_\n🌟| _تم ايقاف التحذير_ ☑️"
			end
	end
	end


	if matches[1] == "ضع الترحيب" and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
		return "🌟| _تم وضع الترحيب بنجاح كلاتي 👋🏻_\n*"..matches[2].."*\n\n🌟| _ملاحظه_\n🌟| _تستطيع اضهار القوانين بواسطه _ ➣ *{rules}*  \n🌟| _تستطيع اضهار الاسم بواسطه_ ➣ *{name}*\n🌟| _تستطيع اضهار المعرف بواسطه_ ➣ *{username}*"
	end

		if matches[1] == "الترحيب"  and is_mod(msg) then
		if data[tostring(chat)]['setwelcome']  then
	    return data[tostring(chat)]['setwelcome']  
	    else
		return "🌟| مرحباً عزيزي\n🌟| نورت المجموعه \n🌟| تابع : @llDEV1ll"
	end
	end
	
	end
	end
-----------------------------------------
local checkmod = true

local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
 	checkmod = false
	tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
	local secchk = true
		for k,v in pairs(b.members_) do
			if v.user_id_ == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
return tdcli.sendMessage(msg.to.id, 0, 1, '_البوت ليس من ضمن الادمنيه ,يرجي رفع البوت ادمن!_', 1, "md")
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://irapi.ir/time/')
          if res ~= 200 then return "فشل الاتصال" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
		return "🌟| مرحباً عزيزي\n🌟| نورت المجموعه \n🌟| تابع : @llDEV1ll"
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
     rules = "🌟| _مرحبأ عزيري_ 👋🏻 _القوانين كلاتي_ 👇🏻\n🌟| _ممنوع نشر الروابط_ \n🌟| _ممنوع التكلم او نشر صور اباحيه_ \n🌟| _ممنوع  اعاده توجيه_ \n🌟| _ممنوع التكلم بلطائفه_ \n🌟| _الرجاء احترام المدراء والادمنيه _😅\n🌟| _تابع _@verxbot 💤"

end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timefa}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "☑️" then
			tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "☑️" then
			tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
        end
		end
	end

 end
 
return {
patterns ={
"^(ايدي)$",
"^(ايدي) (.*)$",
'^(الحمايه)$',
'^(الوسائط)$',
'^(تثبيت)$',
'^(الغاء التثبيت)$',
'^(تفعيل)$',
'^(تعطيل)$',
'^(رفع المدير)$',
'^(رفع المير) (.*)$',
'^(تنزيل المير) (.*)$',
'^(تنزيل المدير)$',
'^(القائمه البيضاء) ([+-]) (.*)$',
'^(القائمه البيضاء) ([+-])$',
'^(القائمه البيضاء)$',
'^(رفع ادمن)$',
'^(رفع ادمن) (.*)$',
'^(تنزيل ادمن) (.*)$',
'^(تنزيل دمن)$',
'^(رفع المدير)$',
'^(رفع المدير) (.*)$',
'^(تنزيل المدير)$',
'^(تنزيل المدير) (.*)$',
'^(قفل) (.*)$',
'^(فتح) (.*)$',
'^(تشغيل) (.*)$',
'^(ايقاف) (.*)$',
'^(اختيار) (.*)$',
'^(الرابط خاص)$',
'^(تغير الرابط)$',
'^(المجموعه)$',
'^(معلومات) (.*)$',
'^(معلومات حول)$',
'^(الاوامر)$',
'^(القوانين)$',
'^(الرابط)$',
'^(ضع رابط)$',
'^(ضع قوانين) (.*)$',
'^(العضو) (.*)$',
'^(ضع تكرار) (%d+)$',
'^(ضع تكرار) (%d+)$',
'^(ضع تكرار بالزمن) (%d+)$',
'^(الاحرف) (%d+)$',
'^(مسح) (.*)$',
'^(الوصف)$',
'^(ضع وصف) (.*)$',
'^(قائمه المنع)$',
'^(المدراء)$',
'^(الادمنيه)$',
'^(منع) (.*)$',
'^(الغاء منع) (.*)$',
'^(ضع الترحيب) (.*)$',
'^(الترحيب)$',
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",

},
run=th3boss,
pre_process = pre_process
}
