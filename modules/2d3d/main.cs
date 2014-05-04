function 2d3d::create( %this )
{
    new Scene(mainScene);
    new SceneWindow(mainWindow);
    mainWindow.profile = new GuiControlProfile();
    Canvas.setContent(mainWindow);
    mainWindow.setScene(mainScene);
    mainWindow.setCameraPosition( 0, 0 );
    mainWindow.setCameraSize( 100, 75 );

    // load some scripts and variables
    // exec("./scripts/someScript.cs");
}

//-----------------------------------------------------------------------------

function 2d3d::destroy( %this )
{
}

//-----------------------------------------------------------------------------