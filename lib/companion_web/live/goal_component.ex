defmodule CompanionWeb.GoalLive.GoalComponent do
  use CompanionWeb, :live_component

  def get_percentage(length, objective) do
    length * 100 / objective
  end

  def render(assigns) do
    ~L"""
    <div>
    <div class="full-w flex flex-row justify-center">
    <div class="relative pt-1 w-4/5">
    <div class="flex mb-2 items-center justify-between">
    <div>
      <span class="text-xs font-semibold inline-block py-1 px-2 uppercase rounded-full text-indigo-600 bg-indigo-200">
       <%= @goal.title %>
      </span>
    </div>
    <div class="text-right">
      <span class="text-xs font-semibold inline-block text-indigo-600">
       <%= to_string(@goal.current_streak) <> " of " <>  to_string(@goal.objective) <> " " <> @goal.unit %>
      </span>
    </div>
    </div>
    <div class="overflow-hidden h-2 mb-4 text-xs flex rounded bg-indigo-200" >
    <div id="<%=String.trim(@goal.title) <> to_string(@goal.id) %>" style="width:<%= get_percentage(@goal.current_streak, @goal.objective)%>%" class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-indigo-500"></div>
    </div>
    </div>

    <div  id="tooltip-content-<%=@goal.id%>" style="display: none;">
        <%= for checkin <- @goal.checkins do %>
         <p> <%=checkin.date%> </p>
        <% end %>
    </div>

    <script>
       tippy('#<%= String.trim(@goal.title) <> to_string(@goal.id) %>', {
       content: document.getElementById("tooltip-content-<%=@goal.id%>").innerHTML,
       allowHTML: true,
       placement: "bottom"
      });

      function updateTippy(){

       const inst = document.getElementById("<%= String.trim(@goal.title) <> to_string(@goal.id) %>")._tippy
       inst.destroy()
       console.log("Destroyed")
      }
    </script>

    <div class="w-1/12 flex justify-center items-center">
    <button onclick="openPopover(event, `goal-<%= @goal.id %>`)" class="shadow-2xl p-2 rounded-lg bg-gray-200 h-12 hover:bg-gray-600 ">
    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24"><path d="M24 9h-9v-9h-6v9h-9v6h9v9h6v-9h9z"/></svg>
    </button>
    </div>
    </div>
    <div class="flex flex-wrap">
    <div class="w-full text-center">
    <div class="hidden shadow bg-indigo-300 border-0 mb-3 block z-50 font-normal leading-normal text-sm max-w-xs text-left no-underline break-words rounded-lg" id="goal-<%= @goal.id %>">
      <div>
        <div class="bg-indigo-300 text-indigo-600 opacity-75 font-semibold p-3 mb-0 border-b border-solid border-gray-200 uppercase rounded-t-lg flex justify-between">
          CHECK IN
          <button onclick="closePopover(`goal-<%= @goal.id %>`)">
          X
          </button>
        </div>
        <form action="#" phx-submit="addCheckin">
          <%= text_input :checkin, :goal_id, value: @goal.id, class: "hidden", id: "goal_id" <> to_string(@goal.id)%>
          <div class="p-3">
           <%= date_input :checkin, :date,  class: "bg-white h-10 px-5 pr-10 rounded-full text-sm focus:outline-none", id: "date" <> to_string(@goal.id)%>
          </div>
        <div  class="content-center flex justify-center" >
        <%= submit "SAVE", phx_disable_with: "Saving...", class: "hover:bg-indigo-800 bg-indigo-600 text-white border border-indigo-600 font-bold py-2 px-6 rounded-lg", onClick: "updateTippy()"%>
        </div>
          </form>
      </div>
    </div>
    </div>
    </div>
    </div>
    """
  end
end
