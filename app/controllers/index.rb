get '/' do
	redirect to '/projects'
end

get '/projects' do
	if params[:sort]
		@projects = Project.sort_by(params).shuffle
	else
		@projects = Project.all.shuffle
	end
  erb :index
end

get '/projects/new' do
	erb :new
end

get '/projects/:id' do
	@project = Project.find params[:id]
	erb :show
end

post '/projects' do
	project = Project.new(params[:project])
	project.validate_links

	if project.save
		redirect "/projects/#{project.id}"
	else
		erb :new
	end
end

post '/projects/search' do
	@projects = Project.search_projects(params).shuffle
end



get '/projects/:id/edit' do
	@project = Project.find(params[:id])
	erb :edit
end

put '/projects/:id' do
	project = Project.find(params[:project][:id])
	project.update_attributes(params[:project])
	redirect "projects/#{@project.id}"
end

delete '/projects/:id' do
	if logged_in? && admin_priviledge? == true
		project = Project.find(params[:id])
	end
	redirect '/'
end


