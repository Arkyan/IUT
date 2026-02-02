import "./App.css";
import Formulaire from "./components/Formulaire";
import "bootstrap/dist/css/bootstrap.css"

function App() {
  return (
    <div className="m-5">
      <header className="title">
        <h1 className="text-center">Mon Formulaire</h1>
      </header>
      <div className="center">
        <Formulaire />
      </div>
    </div>
  );
}

export default App;
