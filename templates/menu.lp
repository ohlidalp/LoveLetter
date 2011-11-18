<%
--------------------------------------------------------------------------------
-- This file is part of LoveLetter project.
--------------------------------------------------------------------------------

if module_doc then
	from = "modules/"..module_doc.name
elseif file_doc then
	from = "files/.."..file_doc.name
elseif package_doc then
	from = "packages/.."..package_doc.name
elseif class_doc then
	from = "classes/.."..class_doc.name
else
	from = ""
end
%>

<strong class='MenuHeading'>LuaDoc</strong>
<ul>
	<%if from == "" then%>
	<li><strong>Index</strong></li>
	<%else%>
	<li><a href="<%=luadoc.doclet.LoveLetter.link("index.html", from)%>">Index</a></li>
	<%end%>
</ul>

<!-- LoveLetter: package list (Count: <%=#doc.packages %>) -->
<%if #doc.packages > 0 then%>
<strong class='menu_heading'>Packages</strong>
<ul>
<%for _, package_name in ipairs(doc.packages) do
	if package_doc and package_doc.name == package_name then%>
	<li><strong><%=package_name%></strong></li>
	<%else%>
	<li>
		<a href="<%=luadoc.doclet.LoveLetter.package_link(package_name, doc, from)%>"><%=package_name%></a>
	</li>
<%	end
end%>
</ul>
<%end%>


<!-- Standart: Module list (Count: <%=#doc.modules %>) -->
<%if not options.nomodules and #doc.modules > 0 then%>
<strong class='menu_heading'>Modules</strong>
<ul>
<%for _, modulename in ipairs(doc.modules) do
	if module_doc and module_doc.name == modulename then%>
	<li><strong><%=modulename%></strong></li>
	<%else%>
	<li>
		<a href="<%=luadoc.doclet.LoveLetter.module_link(modulename, doc, from)%>"><%=modulename%></a>
	</li>
<%	end
end%>
</ul>
<%end%>


<!-- Standart: File list (Count: <%=#doc.files %>) -->
<%if not options.nofiles and #doc.files > 0 then%>
<strong class='menu_heading'>Files</strong>
<ul>
<%for _, filepath in ipairs(doc.files) do
	if file_doc and file_doc.name == filepath then%>
	<li><strong><%=filepath%></strong></li>
	<%else%>
	<li>
		<a href="<%=luadoc.doclet.LoveLetter.file_link(filepath, from)%>"><%=filepath%></a>
	</li>
<%	end
end%>
</ul>
<%end%>



