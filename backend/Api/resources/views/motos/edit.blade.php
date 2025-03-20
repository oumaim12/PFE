<x-app-layout>
    <x-slot name="header">
        <h2 class="header-title flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
            </svg>
            {{ __('Modifier la moto') }}
        </h2>
    </x-slot>

    <div class="content-panel">
        <div class="panel-header">
            <h3 class="panel-title">Édition de la moto #{{ $moto->id }}</h3>
        </div>
        <div class="panel-body p-4">
            @if ($errors->any())
                <div class="bg-engine-red/10 text-engine-red p-4 rounded-md mb-6 border border-engine-red/30">
                    <div class="font-medium">{{ __('Oups! Quelque chose s\'est mal passé.') }}</div>
                    <ul class="mt-3 list-disc list-inside text-sm">
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form action="{{ route('motos.update', $moto->id) }}" method="POST">
                @csrf
                @method('PUT')

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <div class="mb-4">
                            <label for="model_id" class="block text-polished-chrome text-sm font-medium mb-1">Modèle de moto <span class="text-engine-red">*</span></label>
                            <select name="model_id" id="model_id" required class="form-input">
                                <option value="">Sélectionner un modèle</option>
                                @foreach($models as $model)
                                    <option value="{{ $model->id }}" {{ old('model_id', $moto->model_id) == $model->id ? 'selected' : '' }}>
                                        {{ $model->marque }} ({{ $model->annee }})
                                    </option>
                                @endforeach
                            </select>
                            <p class="text-polished-chrome/70 text-xs mt-1">Sélectionnez le modèle de la moto.</p>
                        </div>

                        <!-- Si vous avez des attributs supplémentaires spécifiques aux motos, ajoutez-les ici -->
                        
                        <div class="mt-6">
                            <p class="text-polished-chrome text-sm">Les champs marqués d'un <span class="text-engine-red">*</span> sont obligatoires.</p>
                        </div>
                    </div>

                    <div>
                        <div class="bg-carbon-fiber p-4 rounded-lg mb-4">
                            <h4 class="text-white font-bold mb-3">Informations sur cette moto</h4>
                            <div class="space-y-3 mb-3">
                                <div class="grid grid-cols-2 gap-2">
                                    <div>
                                        <span class="block text-polished-chrome/70 text-xs">ID</span>
                                        <span class="text-white text-sm">{{ $moto->id }}</span>
                                    </div>
                                    <div>
                                        <span class="block text-polished-chrome/70 text-xs">Date d'ajout</span>
                                        <span class="text-white text-sm">{{ $moto->created_at->format('d/m/Y') }}</span>
                                    </div>
                                </div>
                                <div>
                                    <span class="block text-polished-chrome/70 text-xs">Dernière modification</span>
                                    <span class="text-white text-sm">{{ $moto->updated_at->format('d/m/Y H:i') }}</span>
                                </div>
                                <div>
                                    <span class="block text-polished-chrome/70 text-xs">Modèle actuel</span>
                                    <span class="text-white text-sm">{{ $moto->model->marque }} ({{ $moto->model->annee }})</span>
                                </div>
                            </div>
                        </div>

                        <div class="bg-deep-metal rounded-lg p-4">
                            <h4 class="text-white font-bold mb-3">Besoin d'un nouveau modèle ?</h4>
                            <p class="text-polished-chrome mb-3 text-sm">Si vous souhaitez attribuer un modèle qui n'existe pas encore, vous devez d'abord le créer.</p>
                            <a href="{{ route('models.create') }}" class="bg-exhaust-blue hover:bg-blue-700 text-white py-2 px-3 rounded text-sm flex items-center justify-center transition-colors w-full">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                                </svg>
                                Créer un nouveau modèle
                            </a>
                        </div>
                    </div>
                </div>

                <div class="mt-6 flex justify-end space-x-3">
                    <a href="{{ route('motos.show', $moto->id) }}" class="px-4 py-2 bg-carbon-fiber hover:bg-gray-700 text-polished-chrome rounded transition-colors">Annuler</a>
                    <button type="submit" class="moto-button">Enregistrer les modifications</button>
                </div>
            </form>
        </div>
    </div>
</x-app-layout>