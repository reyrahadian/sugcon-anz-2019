<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Sample Inner Sublayout.ascx.cs" Inherits="WebApp.Layouts.WebUserControl1" %>
<div id="InnerCenter">
    <div id="Header">
        <img src="-/media/Default Website/sc_logo.ashx" alt="Sitecore" id="scLogo" />
    </div>
    <div id="Content">
        <div id="LeftContent">
            <sc:placeholder runat="server" key="content" />
        </div>				
    </div>
    <div id="Footer"><hr class="divider"/>SUGCON AUNZ 2019 - <%= Environment.MachineName %></div>
</div>