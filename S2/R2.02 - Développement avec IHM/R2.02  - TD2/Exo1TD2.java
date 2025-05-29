public void start (Stage primaryStage) {
	Button btn1 = new Button();
	btn1.setText("Click button");
	
	//Création d'un Layout Pane de type Hbox
	Hbox root = new Hbox();
	root.setAlignment(Pos.CENTER);
	root.getChildren().add(btn1);
	
	Scene Scene = new Scene (root, 300,250);
	
	primaryStage.setTitle("Exemple Event Filter")
	primaryStage.setScene(scene);
	primaryStage.show();
}

btn1.addEventFilter(MouseEvent.MOUSE_CLICKED, new EventHandler<MouseEvent>() { 
	
	@Override 
	public void handle (MouseEvent event) {
		btn1.setText("Button a été cliqué !!!")
	}
}); 

btn1.addEventHandler(MouseEvent.MOUSE_CLICKED, new EventHandler<MouseEvent>() { 
	
	@Override 
	public void handle (MouseEvent event) {
		btn1.setText("Button a été cliqué !!!")
	}
});










