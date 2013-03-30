###

Copyright (c) 2011-2012  Voicious

This program is free software: you can redistribute it and/or modify it under the terms of the
GNU Affero General Public License as published by the Free Software Foundation, either version
3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this
program. If not, see <http://www.gnu.org/licenses/>.

###

class UserList extends Module
    # The user list contain all the informations of the guests in the room.
    constructor     : (connections) ->
        super connections
        @users  = []
        @jqElem = ($ '#userListUl')
        li      = @jqElem.children 'li'
        @users.push (do li.text)
        do @configureEvents

    configureEvents     : () =>
        @connections.defineAction 'peer.list', @fill
        @connections.defineAction 'peer.create', (event, user) =>
            @update 'create', user
        @connections.defineAction 'peer.remove', (event, user) =>
            @update 'remove', user

    # Fill the user list with new users.
    fill            : (event, data) =>
        for user in data.peers
            @users.push user.name
        do @display

    # Update the user list by creating or removing a user from the list.
    update          : (event, user) =>
        switch event
            when 'create' then @users.push user.name
            when 'remove' then @users.splice (@users.indexOf user.name), 1
        do @display

    # Update the user list window.
    display         : () =>
        do @jqElem.empty
        for user in @users
            @jqElem.append (($ '<li>', { class : 'userBox user' }).text user)

if window?
    window.UserList     = UserList
