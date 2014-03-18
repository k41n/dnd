json.cache! [GameInvitation.maximum(:updated_at), GameInvitation.count] do
    json.array! collection.to_a do |resource|
        json.partial! 'api/invites/invite', resource: resource
    end
end
